import 'package:frida_query_builder/src/query/common/criteria_statement.dart';
import 'package:frida_query_builder/src/query/criterion/criteria_query_builder.dart';
import 'package:frida_query_builder/src/query/select/join_query_builder.dart';
import 'package:frida_query_builder/src/query/select/select.dart';

class SelectQueryBuilder extends CriteriaQueryBuilder {
  Select select;

  SelectQueryBuilder(this.select) : super(select);

  @override
  String build() {
    StringBuffer sb = StringBuffer();

    String alias = "";
    if (select.alias != null) {
      alias = "AS ${select.alias}";
    }

    sb.writeln("SELECT ${_buildProjections()}");
    sb.writeln("FROM ${select.source} $alias");
    if (select.joins.isNotEmpty) {
      select.joins.forEach(
        (join) {
          sb.write(JoinQueryBuilder(join).build());
        },
      );
    }

    if (select.criteria.isNotEmpty) {
      sb.writeln("WHERE ${CriteriaQueryBuilder(CriteriaStatement(
        select.source,
        criteria: select.criteria,
      )).build()}");
    }
    if (select.groupBy.isNotEmpty) {
      sb.writeln(_buildGroupBy());
    }

    if (select.orderBy.isNotEmpty) {
      sb.writeln(_buildOrderBy());
    }
    if (select.offset != null) {
      sb.writeln(_buildOffset());
    }

    return sb.toString();
  }

  String _buildProjections() {
    if (select.columns.isEmpty) {
      return "*";
    }
    return select.columns.join(" , ");
  }

  String _buildGroupBy() {
    final sb = StringBuffer();
    if (select.orderBy.isNotEmpty) {
      sb.write(" GROUP BY " + select.orderBy.join(" , "));
    }

    return sb.toString();
  }

  String _buildOrderBy() {
    final sb = StringBuffer();
    if (select.orderBy.isNotEmpty) {
      sb.write(" ORDER BY " + select.orderBy.join(" , "));
    }

    return sb.toString();
  }

  String _buildOffset() {
    final sb = StringBuffer();
    if (select.limit != null) {
      sb.write("LIMIT ${select.limit.toString()}");
      if (select.offset != null) {
        sb.write(" OFFSET ${select.offset.toString()}");
      }
    }
    return sb.toString();
  }
}
