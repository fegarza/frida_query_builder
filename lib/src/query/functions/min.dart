import 'package:frida_query_builder/frida_query_builder.dart';

class Min extends Field {
  Min(field) : super(field is Field ? "MIN($field)" : 'MIN("$field")');
}
