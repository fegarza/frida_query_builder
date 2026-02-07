import 'package:frida_query_builder/src/query/common/statement.dart';
import 'package:frida_query_builder/src/query/common/statement_visitor.dart';

class Insert extends Statement {
  Map<String, Object?> values;
  Insert({required into, required this.values}) : super(into);

  @override
  T accept<T>(StatementVisitor<T> visitor) {
    return visitor.visitInsert(this);
  }
}
