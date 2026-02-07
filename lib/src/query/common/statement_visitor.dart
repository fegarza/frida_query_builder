import 'package:frida_query_builder/src/query/create/create.dart';
import 'package:frida_query_builder/src/query/delete/delete.dart';
import 'package:frida_query_builder/src/query/insert/insert.dart';
import 'package:frida_query_builder/src/query/select/select.dart';
import 'package:frida_query_builder/src/query/update/update.dart';
import 'package:frida_query_builder/src/query/common/criteria_statement.dart';

abstract class StatementVisitor<T> {
  T visitCreate(Create statement);
  T visitInsert(Insert statement);
  T visitSelect(Select statement);
  T visitUpdate(Update statement);
  T visitDelete(Delete statement);
  T visitCriteria(CriteriaStatement statement);
}
