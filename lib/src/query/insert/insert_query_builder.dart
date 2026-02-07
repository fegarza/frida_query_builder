import 'package:frida_query_builder/src/query/common/frida_query_builder.dart';
import 'package:frida_query_builder/src/query/criterion/field_query_builder.dart';
import 'package:frida_query_builder/src/query/insert/insert.dart';

class InsertQueryBuilder extends FridaQueryBuilder {
  Insert insert;

  InsertQueryBuilder(this.insert) : super(insert);

  @override
  String build() {
    StringBuffer sb = StringBuffer();
    sb.write("INSERT INTO ${insert.source}(");
    sb.write(insert.values.keys.toList().join(", ") + ")");
    sb.write(" VALUES(");
    sb.write(insert.values.values
            .toList()
            .map(
              (e) => FieldQueryBuilder(e).build(),
            )
            .join(", ") +
        ");");
    return sb.toString();
  }
}
