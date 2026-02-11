import 'package:frida_query_builder/src/query/common/statement.dart';
import 'package:frida_query_builder/src/query/common/statement_visitor.dart';

class Insert extends Statement {
  Map<String, Object?> values;
  Insert({required dynamic into, required this.values}) : super(into);

  Insert setValues(Map<String, Object?> values) {
    this.values = values;
    return this;
  }

  Insert addValue(String column, Object? value) {
    this.values[column] = value;
    return this;
  }

  @override
  T accept<T>(StatementVisitor<T> visitor) {
    return visitor.visitInsert(this);
  }
}
