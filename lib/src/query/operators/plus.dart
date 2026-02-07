import 'package:frida_query_builder/frida_query_builder.dart';

class Plus extends Operator {
  Plus({required Field left, required Field right})
      : super(operator: "+", left: left, right: right);
}
