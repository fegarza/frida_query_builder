import 'package:frida_query_builder/src/query/common/query_builder.dart';
import 'package:frida_query_builder/src/query/create/column/column.dart';

class PrimaryKeyQueryBuilder implements QueryBuilder {
  List<Column> columns;

  PrimaryKeyQueryBuilder(this.columns);

  @override
  String build() {
    var sb = StringBuffer();

    sb.write("PRIMARY KEY(" +
        columns
            .where((element) => element.isPrimaryKey)
            .map((e) => e.name)
            .join(", ") +
        ")");
    return sb.toString();
  }
}
