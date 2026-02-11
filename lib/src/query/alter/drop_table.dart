import 'package:frida_query_builder/src/query/alter/alter.dart';
import 'package:frida_query_builder/src/query/common/statement_visitor.dart';

class DropTable extends Alter {
  DropTable(String tableName) : super(tableName);

  @override
  T accept<T>(StatementVisitor<T> visitor) => visitor.visitDropTable(this);
}
