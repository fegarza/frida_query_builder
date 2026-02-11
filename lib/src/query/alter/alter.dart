import 'package:frida_query_builder/src/query/common/statement.dart';
import 'package:frida_query_builder/src/query/common/statement_visitor.dart';

abstract class Alter extends Statement {
  Alter(String tableName) : super(tableName);

  @override
  T accept<T>(StatementVisitor<T> visitor);
}
