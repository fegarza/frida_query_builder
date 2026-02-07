import 'package:frida_query_builder/frida_query_builder.dart';
import 'package:frida_query_builder/src/query/operators/operator.dart';

class Minus extends Operator {
  Minus({required Field left, required Field right})
      : super(operator: "-", left: left, right: right);
}
