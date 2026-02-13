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
import 'package:frida_query_builder/src/query/criterion/criterion_compare_query_builder.dart';

import 'package:frida_query_builder/src/query/criterion/criterion_compare.dart';
import 'package:frida_query_builder/src/query/criterion/criterion_logic.dart';

import 'package:frida_query_builder/src/query/alter/add_column.dart';
import 'package:frida_query_builder/src/query/alter/drop_column.dart';
import 'package:frida_query_builder/src/query/alter/drop_table.dart';
import 'package:frida_query_builder/src/query/alter/rename_column.dart';
import 'package:frida_query_builder/src/query/alter/rename_table.dart';
import 'package:frida_query_builder/src/query/index/create_index.dart';
import 'package:frida_query_builder/src/query/index/drop_index.dart';

class SqlRenderer implements StatementVisitor<String> {
  @override
  String visitRenameTable(RenameTable statement) {
    return "ALTER TABLE ${statement.source} RENAME TO ${statement.newName};";
  }

  @override
  String visitAddColumn(AddColumn statement) {
    return "ALTER TABLE ${statement.source} ADD COLUMN ${ColumnQueryBuilder(statement.column).build()};";
  }

  @override
  String visitRenameColumn(RenameColumn statement) {
    return "ALTER TABLE ${statement.source} RENAME COLUMN ${statement.oldName} TO ${statement.newName};";
  }

  @override
  String visitDropColumn(DropColumn statement) {
    return "ALTER TABLE ${statement.source} DROP COLUMN ${statement.columnName};";
  }

  @override
  String visitDropTable(DropTable statement) {
    return "DROP TABLE ${statement.source};";
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
    if (statement.rows.isEmpty) {
      return '';
    }
    StringBuffer sb = StringBuffer();
    sb.write('INSERT INTO ${statement.source}(');

    // Use columns from the first row as template
    final columns = statement.rows.first.keys.toList();
    sb.write('${columns.join(', ')})');
    sb.write(' VALUES ');

    final List<String> valuesList = [];
    for (var row in statement.rows) {
      final rowValues =
          columns.map((col) => FieldQueryBuilder(row[col]).build()).join(', ');
      valuesList.add('($rowValues)');
    }

    sb.write('${valuesList.join(', ')};');
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
  String visitCreateIndex(CreateIndex statement) {
    return "CREATE ${statement.unique ? "UNIQUE " : ""}INDEX ${statement.indexName} ON ${statement.source} (${statement.columns.join(", ")});";
  }

  @override
  String visitDropIndex(DropIndex statement) {
    return "DROP INDEX ${statement.indexName};";
  }

  @override
  String visitCriteria(CriteriaStatement statement) {
    return statement.criteria.map((c) => c.accept(this)).join(" AND ");
  }

  @override
  String visitCriterionLogic(CriterionLogic statement) {
    if (statement.criteria.isEmpty) {
      return "";
    }

    if (statement.criterionOperator == "NOT") {
      return "NOT (${statement.criteria.first.accept(this)})";
    }

    return "(" +
        statement.criteria
            .map((c) => c.accept(this))
            .join(" ${statement.criterionOperator} ") +
        ")";
  }

  @override
  String visitCriterionCompare(CriterionCompare statement) {
    return CriterionCompareQueryBuilder(statement).build();
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
