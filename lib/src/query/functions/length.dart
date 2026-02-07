import 'package:frida_query_builder/frida_query_builder.dart';

class Length extends Field {
  Length(field) : super("LENGTH($field)");
}
