import 'package:frida_query_builder/frida_query_builder.dart';
import 'package:frida_query_builder/src/query/common/criteria_statement.dart';
import 'package:frida_query_builder/src/query/criterion/criterion_logic.dart';
import 'package:frida_query_builder/src/query/criterion/criterion_compare.dart';

abstract class StatementVisitor<T> {
  T visitCreate(Create statement);
  T visitInsert(Insert statement);
  T visitSelect(Select statement);
  T visitUpdate(Update statement);
  T visitDelete(Delete statement);
  T visitCriteria(CriteriaStatement statement);

  // Index statements
  T visitCreateIndex(CreateIndex statement);
  T visitDropIndex(DropIndex statement);

  // Alter statements
  T visitRenameTable(RenameTable statement);
  T visitAddColumn(AddColumn statement);
  T visitRenameColumn(RenameColumn statement);
  T visitDropColumn(DropColumn statement);
  T visitDropTable(DropTable statement);

  // Criteria
  T visitCriterionLogic(CriterionLogic statement);
  T visitCriterionCompare(CriterionCompare statement);
}
