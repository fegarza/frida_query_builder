import 'package:frida_query_builder/src/query/common/criteria_statement.dart';
import 'package:frida_query_builder/src/query/common/statement_visitor.dart';
import 'package:frida_query_builder/src/query/create/create.dart';
import 'package:frida_query_builder/src/query/delete/delete.dart';
import 'package:frida_query_builder/src/query/insert/insert.dart';
import 'package:frida_query_builder/src/query/select/select.dart';
import 'package:frida_query_builder/src/query/update/update.dart';

// Helper imports
import 'package:frida_query_builder/src/query/create/column/column_query_builder.dart';
import 'package:frida_query_builder/src/query/create/foreign_key_query_builder.dart';
import 'package:frida_query_builder/src/query/create/primary_key_query_builder.dart';
import 'package:frida_query_builder/src/query/criterion/field_query_builder.dart';
import 'package:frida_query_builder/src/query/select/join_query_builder.dart';
import 'package:frida_query_builder/src/query/criterion/criterion_logic_query_builder.dart';
import 'package:frida_query_builder/src/query/criterion/criterion_compare_query_builder.dart';

import 'package:frida_query_builder/src/query/criterion/criterion_compare.dart';
import 'package:frida_query_builder/src/query/criterion/criterion_login.dart';

import 'package:frida_query_builder/src/query/alter/alter.dart';
import 'package:frida_query_builder/src/query/alter/add_column.dart';
import 'package:frida_query_builder/src/query/alter/drop_column.dart';
import 'package:frida_query_builder/src/query/alter/drop_table.dart';
import 'package:frida_query_builder/src/query/alter/rename_column.dart';
import 'package:frida_query_builder/src/query/alter/rename_table.dart';

class SqlRenderer implements StatementVisitor<String> {
  @override
  String visitAlter(Alter statement) {
    var sb = StringBuffer();

    if (statement is RenameTable) {
      sb.write(
          "ALTER TABLE ${statement.source} RENAME TO ${statement.newName};");
      return sb.toString();
    }

    if (statement is AddColumn) {
      sb.write(
          "ALTER TABLE ${statement.source} ADD COLUMN ${ColumnQueryBuilder(statement.column).build()};");
      return sb.toString();
    }

    if (statement is RenameColumn) {
      sb.write(
          "ALTER TABLE ${statement.source} RENAME COLUMN ${statement.oldName} TO ${statement.newName};");
      return sb.toString();
    }

    if (statement is DropColumn) {
      sb.write(
          "ALTER TABLE ${statement.source} DROP COLUMN ${statement.columnName};");
      return sb.toString();
    }

    if (statement is DropTable) {
      sb.write("DROP TABLE ${statement.source};");
      return sb.toString();
    }

    return sb.toString();
  }

  @override
  String visitCreate(Create statement) {
    var sb = StringBuffer();
    final tableName = statement.source;
    sb.writeln("CREATE TABLE $tableName(");

    final definitionsBuilders = [];
    definitionsBuilders
        .addAll(statement.columns.map((e) => ColumnQueryBuilder(e)));

    if (statement.columns.where((w) => w.isAutoIncrement).isEmpty) {
      definitionsBuilders.add(PrimaryKeyQueryBuilder(
          statement.columns.where((w) => w.isPrimaryKey).toList()));
    }

    var foreignKeyColumns =
        statement.columns.where((w) => w.foreignKey != null).toList();

    if (foreignKeyColumns.isNotEmpty) {
      definitionsBuilders.add(ForeignKeyQueryBuilder(foreignKeyColumns));
    }

    sb.writeln(definitionsBuilders.map((e) => " " + e.build()).join(",\n"));
    sb.write(");");

    return sb.toString();
  }

  @override
  String visitInsert(Insert statement) {
    StringBuffer sb = StringBuffer();
    sb.write("INSERT INTO ${statement.source}(");
    sb.write(statement.values.keys.toList().join(", ") + ")");
    sb.write(" VALUES(");
    sb.write(statement.values.values
            .toList()
            .map(
              (e) => FieldQueryBuilder(e).build(),
            )
            .join(", ") +
        ");");
    return sb.toString();
  }

  @override
  String visitSelect(Select statement) {
    StringBuffer sb = StringBuffer();

    String alias = "";
    if (statement.alias != null) {
      alias = " AS ${statement.alias}";
    }

    sb.writeln(
        "SELECT ${statement.distinct ? "DISTINCT " : ""}${_buildProjections(statement)}");
    sb.write("FROM ${statement.source}$alias");
    if (statement.joins.isNotEmpty) {
      sb.write("\n");
      for (final join in statement.joins) {
        sb.write(JoinQueryBuilder(join).build());
      }
    }

    if (statement.criteria.isNotEmpty) {
      sb.write("\n");
      // Recursively visit criteria
      sb.write("WHERE ${visitCriteria(CriteriaStatement(
        statement.source,
        criteria: statement.criteria,
      ))}");
    }

    if (statement.groupBy.isNotEmpty) {
      sb.write("\n");
      sb.write(_buildGroupBy(statement));
      if (statement.having.isNotEmpty) {
        sb.write(" HAVING ${visitCriteria(CriteriaStatement(
          statement.source,
          criteria: statement.having,
        ))}");
      }
    }

    if (statement.orderBy.isNotEmpty) {
      sb.write("\n");
      sb.writeln(_buildOrderBy(statement));
    }
    if (statement.limit != null) {
      sb.write("\n");
      sb.write(_buildOffset(statement));
    }

    sb.write(";");
    return sb.toString();
  }

  @override
  String visitUpdate(Update statement) {
    StringBuffer sb = StringBuffer();

    sb.write("UPDATE ${statement.source} SET ${_buildSetString(statement)}");

    if (statement.criteria.isNotEmpty) {
      sb.write("\n");
      sb.write("WHERE ${visitCriteria(CriteriaStatement(
        statement.source,
        criteria: statement.criteria,
      ))}");
    }

    sb.write(";");
    return sb.toString();
  }

  @override
  String visitDelete(Delete statement) {
    StringBuffer sb = StringBuffer();

    sb.write("DELETE FROM ${statement.source}");

    if (statement.criteria.isNotEmpty) {
      sb.write("\n");
      sb.write("WHERE ${visitCriteria(CriteriaStatement(
        statement.source,
        criteria: statement.criteria,
      ))}");
    }

    sb.write(";");
    return sb.toString();
  }

  @override
  String visitCriteria(CriteriaStatement statement) {
    var sb = StringBuffer();
    bool isFirstIteration = true;

    for (final criteria in statement.criteria) {
      if (criteria is CriterionLogic) {
        sb.write(
          CriterionLogicQueryBuilder(criteria,
                  quoted: criteria.firstFieldQuoted)
              .build(),
        );
      }

      if (criteria is CriterionCompare) {
        if (!isFirstIteration) {
          sb.write(" AND ");
        }
        sb.write(
          CriterionCompareQueryBuilder(
            criteria,
            firstFieldQuoted: criteria.firstFieldQuoted,
            secondFieldQuoted: criteria.secondFieldQuoted,
          ).build(),
        );
      }

      isFirstIteration = false;
    }

    return sb.toString();
  }

  // Helper methods for Select
  String _buildProjections(Select select) {
    if (select.columns.isEmpty) {
      return "*";
    }
    return select.columns.map((e) => FieldQueryBuilder(e).build()).join(", ");
  }

  String _buildGroupBy(Select select) {
    final sb = StringBuffer();
    if (select.groupBy.isNotEmpty) {
      sb.write(" GROUP BY " + select.groupBy.join(", "));
    }
    return sb.toString();
  }

  String _buildOrderBy(Select select) {
    final sb = StringBuffer();
    if (select.orderBy.isNotEmpty) {
      sb.write(" ORDER BY " + select.orderBy.join(", "));
    }
    return sb.toString();
  }

  String _buildOffset(Select select) {
    final sb = StringBuffer();
    if (select.limit != null) {
      sb.write("LIMIT ${select.limit.toString()}");
      if (select.offset != null) {
        sb.write(" OFFSET ${select.offset.toString()}");
      }
    }
    return sb.toString();
  }

  // Helper methods for Update
  String _buildSetString(Update update) {
    StringBuffer sb = StringBuffer();
    bool isFirstValue = true;
    update.values.forEach(
      (key, value) {
        if (!isFirstValue) {
          sb.write(",");
        }
        sb.write("$key = ${FieldQueryBuilder(value).build()} ");

        isFirstValue = false;
      },
    );
    return sb.toString();
  }
}
