import 'package:frida_query_builder/frida_query_builder.dart';

class Count extends Field {
  Count(field) : super(field is Field ? "COUNT($field)" : 'COUNT("$field")');
}
