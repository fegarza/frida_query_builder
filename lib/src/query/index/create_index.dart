import 'package:frida_query_builder/src/query/common/statement.dart';
import 'package:frida_query_builder/src/query/common/statement_visitor.dart';

/// Represents an SQL CREATE INDEX statement.
class CreateIndex extends Statement {
  /// The name of the index.
  final String indexName;

  /// The list of columns to be indexed.
  final List<String> columns;

  /// Whether the index should be UNIQUE.
  final bool unique;

  CreateIndex({
    required this.indexName,
    required String on,
    required this.columns,
    this.unique = false,
  }) : super(on);

  @override
  T accept<T>(StatementVisitor<T> visitor) {
    return visitor.visitCreateIndex(this);
  }
}
