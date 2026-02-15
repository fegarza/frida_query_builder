import 'package:frida_query_builder/src/query/common/statement.dart';
import 'package:frida_query_builder/src/query/common/statement_visitor.dart';

/// Represents an SQL DROP INDEX statement.
class DropIndex extends Statement {
  /// The name of the index to drop.
  final String indexName;

  DropIndex(this.indexName) : super(indexName);

  @override
  T accept<T>(StatementVisitor<T> visitor) {
    return visitor.visitDropIndex(this);
  }
}
