import 'package:frida_query_builder/src/query/common/criteria_statement.dart';
import 'package:frida_query_builder/src/query/common/query_builder.dart';
import 'package:frida_query_builder/src/query/create/column/column.dart';
import 'package:frida_query_builder/src/query/create/column/column_data_type.dart';
import 'package:frida_query_builder/src/query/criterion/criteria_query_builder.dart';

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

    if (column.isUnique) {
      sb.write(" UNIQUE");
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

    if (column.checkConstraints != null &&
        column.checkConstraints!.isNotEmpty) {
      sb.write(" CHECK(${CriteriaQueryBuilder(
        CriteriaStatement(column.name, criteria: column.checkConstraints!),
      ).build()})");
    }

    return sb.toString();
  }
}
