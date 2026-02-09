import 'package:frida_query_builder/frida_query_builder.dart';

class Length extends Field {
  Length(dynamic field)
      : super(field is Field ? "LENGTH($field)" : 'LENGTH("$field")');
}
