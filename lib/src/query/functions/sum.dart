import 'package:frida_query_builder/frida_query_builder.dart';

class Sum extends Field {
  Sum(field) : super("MIN($field)");
}
