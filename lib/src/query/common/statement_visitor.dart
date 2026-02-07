import 'package:frida_query_builder/frida_query_builder.dart';
import 'package:frida_query_builder/src/query/common/criteria_statement.dart';

abstract class StatementVisitor<T> {
  T visitCreate(Create statement);
  T visitInsert(Insert statement);
  T visitSelect(Select statement);
  T visitUpdate(Update statement);
  T visitDelete(Delete statement);
  T visitCriteria(CriteriaStatement statement);
  T visitAlter(Alter statement);
}
