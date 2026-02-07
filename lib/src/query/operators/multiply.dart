import 'package:frida_query_builder/frida_query_builder.dart';

class Multiply extends Operator {
  Multiply({required Field left, required Field right})
      : super(operator: "*", left: left, right: right);
}
