import 'package:frida_query_builder/src/query/common/frida_query_builder.dart';
import 'package:frida_query_builder/src/query/insert/insert.dart';

class InsertQueryBuilder extends FridaQueryBuilder {
  Insert insert;

  InsertQueryBuilder(this.insert) : super(insert);

  @override
  String build() {
    // TODO: implement build
    throw UnimplementedError();
  }
}
