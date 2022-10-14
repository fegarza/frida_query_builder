import 'package:frida_query_builder/src/query/common/criteria_statement.dart';
import 'package:frida_query_builder/src/query/criterion/criterion.dart';
import 'package:frida_query_builder/src/query/select/join_type.dart';
export 'package:frida_query_builder/src/query/select/join_type.dart';

class Join extends CriteriaStatement {
  String? alias;
  JoinType type;
  Join(
    String source, {
    this.alias,
    List<Criterion> criteria = const [],
    this.type = JoinType.inner,
  }) : super(
          source,
          criteria: criteria,
        );
}
