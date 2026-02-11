import 'package:frida_query_builder/src/query/common/statement.dart';
import 'package:frida_query_builder/src/query/common/statement_visitor.dart';

/// Represents an SQL INSERT statement.
class Insert extends Statement {
  /// Map of column names to their values.
  Map<String, Object?> values;

  Insert({required dynamic into, required this.values}) : super(into);

  /// Replaces the existing values map with [values].
  Insert setValues(Map<String, Object?> values) {
    this.values = values;
    return this;
  }

  /// Adds or updates a single value for a given [column].
  Insert addValue(String column, Object? value) {
    this.values[column] = value;
    return this;
  }

  @override
  T accept<T>(StatementVisitor<T> visitor) {
    return visitor.visitInsert(this);
  }
}
