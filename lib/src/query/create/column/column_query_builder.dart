import 'package:frida_query_builder/src/query/common/query_builder.dart';
import 'package:frida_query_builder/src/query/create/column/column.dart';
import 'package:frida_query_builder/src/query/create/column/column_data_type.dart';

class ColumnQueryBuilder implements QueryBuilder {
  Column column;

  ColumnQueryBuilder(this.column);

  @override
  String build() {
    var sb = StringBuffer();

    sb.write("${column.name} ${column.type.getString()}");
    if (column.isNotNull) {
      sb.write(" NOT NULL");
    }

    if (column.isAutoIncrement) {
      sb.write(" PRIMARY KEY AUTOINCREMENT");
    }

    if (column.defaultValue != null) {
      final defaultValue = (column.type == ColumnDataType.text)
          ? '"${column.defaultValue}"'
          : "${column.defaultValue}";

      sb.write(' DEFAULT($defaultValue)');
    }

    return sb.toString();
  }
}
