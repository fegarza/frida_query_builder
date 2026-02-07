import 'package:frida_query_builder/frida_query_builder.dart';

class Divide extends Operator {
  Divide({required Field left, required Field right})
      : super(operator: "/", left: left, right: right);
}
