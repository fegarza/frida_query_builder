import 'package:frida_query_builder/src/query/common/criteria_statement.dart';
import 'package:frida_query_builder/src/query/criterion/criteria_query_builder.dart';
import 'package:frida_query_builder/src/query/select/join.dart';

class JoinQueryBuilder extends CriteriaQueryBuilder {
  Join join;

  JoinQueryBuilder(this.join) : super(join);

  @override
  String build() {
    var sb = StringBuffer();

    String alias = "";
    if (join.alias != null) {
      alias = " AS ${join.alias}";
    }

    sb.write("${join.type.getString()} ${join.source}$alias");

    if (criteriaStatement.criteria.isNotEmpty) {
      sb.write("\n");
      sb.write(
        " ON${CriteriaQueryBuilder(
          CriteriaStatement(
            join.source,
            criteria: join.criteria,
          ),
        ).build()}",
      );
    }

    return sb.toString();
  }
}
