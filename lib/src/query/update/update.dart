import 'package:frida_query_builder/src/query/common/criteria_statement.dart';
import 'package:frida_query_builder/src/query/common/statement_visitor.dart';
import 'package:frida_query_builder/src/query/criterion/criterion.dart';

/// Represents an SQL UPDATE statement.
class Update extends CriteriaStatement {
  /// Map of column names to their new values.
  Map<String, Object?> values;

  Update({
    required String table,
    List<Criterion> criteria = const [],
    required this.values,
  }) : super(
          table,
          criteria: [...criteria],
        );

  /// Appends [criteria] to the WHERE clause using an AND connector.
  Update where(List<Criterion> criteria) {
    this.criteria = [...this.criteria, ...criteria];
    return this;
  }

  /// Replaces the existing values map with [values].
  Update setValues(Map<String, Object?> values) {
    this.values = values;
    return this;
  }

  /// Adds or updates a single value for a given [column].
  Update addValue(String column, Object? value) {
    this.values[column] = value;
    return this;
  }

  @override
  T accept<T>(StatementVisitor<T> visitor) {
    return visitor.visitUpdate(this);
  }
}
