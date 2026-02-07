import 'package:frida_query_builder/frida_query_builder.dart';

abstract class Operator extends Field {
  final String operator;
  final Field left;
  final Field right;

  Operator({required this.operator, required this.left, required this.right})
      : super('');
}
