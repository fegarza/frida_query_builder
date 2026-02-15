import 'package:frida_query_builder/src/query/common/criteria_statement.dart';
import 'package:frida_query_builder/src/query/criterion/criterion.dart';
import 'package:frida_query_builder/src/query/select/join_type.dart';
export 'package:frida_query_builder/src/query/select/join_type.dart';

/// Represents an SQL JOIN clause.
class Join extends CriteriaStatement {
  /// Optional alias for the joined table.
  String? alias;

  /// The type of join (INNER, LEFT, etc.).
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
