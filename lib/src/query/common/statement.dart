import 'package:frida_query_builder/src/query/common/statement_visitor.dart';

/// Represents a base SQL statement.
abstract class Statement {
  /// The source table or entity for the statement.
  String source;

  Statement(this.source);

  /// Standard Accept method for the Visitor pattern.
  T accept<T>(StatementVisitor<T> visitor);
}
