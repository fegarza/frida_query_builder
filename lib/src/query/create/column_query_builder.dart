import 'package:frida_query_builder/src/query/common/query_builder.dart';
import 'package:frida_query_builder/src/query/create/column.dart';

class ColumnQueryBuilder implements QueryBuilder {
  Column column;

  ColumnQueryBuilder(this.column);

  @override
  String build() {
    var sb = StringBuffer();

    sb.write(" ${column.name} ${column.type.getString()} ");
    if (column.isNotNull) {
      sb.write("NOT NULL ");
    }

    if (column.isAutoIncrement) {
      sb.write("AUTO INCREMENT ");
    }

    if (column.defaultValue != null) {
      sb.write("DEFAULT(${column.defaultValue}) ");
    }

    return sb.toString();
  }
}
