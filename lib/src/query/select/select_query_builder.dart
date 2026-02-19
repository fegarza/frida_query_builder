import 'package:frida_query_builder/src/query/common/criteria_statement.dart';
import 'package:frida_query_builder/src/query/criterion/criteria_query_builder.dart';
import 'package:frida_query_builder/src/query/criterion/field_query_builder.dart';
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

    sb.write(
        "SELECT ${select.distinct ? "DISTINCT " : ""}${_buildProjections()}");
    if (select.source != null) {
      sb.write("\nFROM ${select.source} $alias");
    }
    if (select.joins.isNotEmpty) {
      for (final join in select.joins) {
        sb.write(JoinQueryBuilder(join).build());
      }
    }

    if (select.criteria.isNotEmpty) {
      sb.write("\nWHERE ${CriteriaQueryBuilder(CriteriaStatement(
        select.source,
        criteria: select.criteria,
      )).build()}");
    }

    if (select.groupBy.isNotEmpty) {
      sb.write("\n${_buildGroupBy()}");
      if (select.having.isNotEmpty) {
        sb.write(" HAVING${CriteriaQueryBuilder(CriteriaStatement(
          select.source,
          criteria: select.having,
        )).build()}");
      }
    }

    if (select.orderBy.isNotEmpty) {
      sb.write("\n${_buildOrderBy()}");
    }
    if (select.limit != null) {
      sb.write(_buildOffset());
    }

    sb.write(";");
    return sb.toString();
  }

  String _buildProjections() {
    if (select.columns.isEmpty) {
      return "*";
    }
    return select.columns.map((e) => FieldQueryBuilder(e).build()).join(", ");
  }

  String _buildGroupBy() {
    final sb = StringBuffer();
    if (select.groupBy.isNotEmpty) {
      sb.write(" GROUP BY " + select.groupBy.join(", "));
    }

    return sb.toString();
  }

  String _buildOrderBy() {
    final sb = StringBuffer();
    if (select.orderBy.isNotEmpty) {
      sb.write(" ORDER BY " + select.orderBy.join(", "));
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
