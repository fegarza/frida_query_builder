import 'package:frida_query_builder/frida_query_builder.dart';

class Max extends Field {
  Max(field) : super(field is Field ? "MAX($field)" : 'MAX("$field")');
}
