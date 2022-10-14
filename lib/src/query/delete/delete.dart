import 'package:frida_query_builder/src/query/common/criteria_statement.dart';
import 'package:frida_query_builder/src/query/criterion/criterion.dart';

class Delete extends CriteriaStatement {
  Delete({
    required String table,
    List<Criterion> criteria = const [],
  }) : super(
          table,
          criteria: criteria,
        );
}
