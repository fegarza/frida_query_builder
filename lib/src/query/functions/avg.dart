import 'package:frida_query_builder/frida_query_builder.dart';

class Avg extends Field {
  Avg(field) : super("AVG($field)");
}
