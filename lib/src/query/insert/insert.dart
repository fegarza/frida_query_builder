import 'package:frida_query_builder/src/query/common/statement.dart';
import 'package:frida_query_builder/src/query/common/statement_visitor.dart';

/// Represents an SQL INSERT statement.
class Insert extends Statement {
  /// List of rows to insert. Each row is a map of column names to their values.
  final List<Map<String, Object?>> rows = [];

  Insert({required dynamic into, Map<String, Object?>? values}) : super(into) {
    if (values != null) {
      rows.add(Map.from(values));
    }
  }

  /// Replaces the existing rows with a single row containing [values].
  Insert setValues(Map<String, Object?> values) {
    rows.clear();
    rows.add(values);
    return this;
  }

  /// Adds a single row to the insert statement.
  Insert addRow(Map<String, Object?> row) {
    rows.add(row);
    return this;
  }

  /// Adds multiple rows to the insert statement.
  Insert addRows(List<Map<String, Object?>> rows) {
    this.rows.addAll(rows);
    return this;
  }

  /// Adds or updates a single value for the first row.
  /// If no rows exist, a new row is created.
  Insert addValue(String column, Object? value) {
    if (rows.isEmpty) {
      rows.add({column: value});
    } else {
      rows.first[column] = value;
    }
    return this;
  }

  /// Legacy getter for the first row's values.
  Map<String, Object?> get values => rows.isNotEmpty ? rows.first : {};

  @override
  T accept<T>(StatementVisitor<T> visitor) {
    return visitor.visitInsert(this);
  }
}
