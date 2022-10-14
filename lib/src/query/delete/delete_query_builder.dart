import 'package:frida_query_builder/src/query/common/criteria_statement.dart';
import 'package:frida_query_builder/src/query/criterion/criteria_query_builder.dart';
import 'package:frida_query_builder/src/query/delete/delete.dart';

class DeleteQueryBuilder extends CriteriaQueryBuilder {
  Delete delete;

  DeleteQueryBuilder(this.delete) : super(delete);

  @override
  String build() {
    StringBuffer sb = StringBuffer();

    sb.writeln("DELETE ${delete.source} ");

    if (delete.criteria.isNotEmpty) {
      sb.writeln("WHERE ${CriteriaQueryBuilder(CriteriaStatement(
        delete.source,
        criteria: delete.criteria,
      )).build()}");
    }
    return sb.toString();
  }
}
