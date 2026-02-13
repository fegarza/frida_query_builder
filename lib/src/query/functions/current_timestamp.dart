import 'package:frida_query_builder/frida_query_builder.dart';

class CurrentTimestamp extends Field {
  CurrentTimestamp() : super('CURRENT_TIMESTAMP');

  @override
  String toString() => field;
}
