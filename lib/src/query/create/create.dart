import 'package:frida_query_builder/src/query/common/statement.dart';
import 'package:frida_query_builder/src/query/common/statement_visitor.dart';
import 'package:frida_query_builder/src/query/create/column/column.dart';

/// Represents an SQL CREATE TABLE statement.
class Create extends Statement {
  /// The list of columns to define in the table.
  List<Column> columns;

  /// Whether to include the IF NOT EXISTS clause.
  bool isIfNotExists = false;

  Create({
    required String tableName,
    this.columns = const [],
    this.isIfNotExists = false,
  }) : super(tableName);

  /// Sets [isIfNotExists] to true.
  Create ifNotExists() {
    this.isIfNotExists = true;
    return this;
  }

  /// Appends a single [column] to the table definition.
  Create addColumn(Column column) {
    this.columns = [...this.columns, column];
    return this;
  }

  /// Appends a list of [columns] to the table definition.
  Create addColumns(List<Column> columns) {
    this.columns = [...this.columns, ...columns];
    return this;
  }

  @override
  T accept<T>(StatementVisitor<T> visitor) {
    return visitor.visitCreate(this);
  }
}
