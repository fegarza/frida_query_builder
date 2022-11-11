import 'package:frida_query_builder/src/query/common/criteria_statement.dart';
import 'package:frida_query_builder/src/query/criterion/criterion.dart';

class Update extends CriteriaStatement {
  Map<String, Object?> values;

  Update({
    required String table,
    List<Criterion> criteria = const [],
    required this.values,
  }) : super(
          table,
          criteria: criteria,
        );
}
