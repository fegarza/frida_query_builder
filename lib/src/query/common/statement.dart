import 'package:frida_query_builder/src/query/common/statement_visitor.dart';

abstract class Statement {
  String source;
  Statement(this.source);

  T accept<T>(StatementVisitor<T> visitor);
}
