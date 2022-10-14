import 'package:frida_query_builder/src/query/common/frida_query_builder.dart';
import 'package:frida_query_builder/src/query/common/query_builder.dart';
import 'package:frida_query_builder/src/query/common/statement.dart';
import 'package:frida_query_builder/src/query/create/create.dart';

class CreateQueryBuilder extends FridaQueryBuilder {
  Create create;

  CreateQueryBuilder(this.create) : super(create);

  @override
  String build() {
    // TODO: implement build
    throw UnimplementedError();
  }
}
