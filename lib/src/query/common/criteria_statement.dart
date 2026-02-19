import 'package:frida_query_builder/src/query/common/statement.dart';
import 'package:frida_query_builder/src/query/common/statement_visitor.dart';
import 'package:frida_query_builder/src/query/criterion/criterion.dart';

/// Represents an SQL statement that can have a WHERE clause (criteria).
class CriteriaStatement extends Statement {
  /// The list of criteria for this statement.
  List<Criterion> criteria;

  CriteriaStatement(String? source, {this.criteria = const []}) : super(source);

  @override
  T accept<T>(StatementVisitor<T> visitor) {
    return visitor.visitCriteria(this);
  }
}
