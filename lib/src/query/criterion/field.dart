import 'package:frida_query_builder/src/query/operators/plus.dart';
import 'package:frida_query_builder/src/query/operators/minus.dart';
import 'package:frida_query_builder/src/query/operators/multiply.dart';
import 'package:frida_query_builder/src/query/operators/divide.dart';
import 'package:frida_query_builder/src/query/operators/modulo.dart';

class Field {
  String field;
  String? alias;

  Field(this.field, {this.alias});

  Field as(String alias) {
    this.alias = alias;
    return this;
  }

  @override
  String toString() => field;

  // Arithmetic operators
  Plus plus(Field other) => Plus(left: this, right: other);
  Minus minus(Field other) => Minus(left: this, right: other);
  Multiply multiply(Field other) => Multiply(left: this, right: other);
  Divide divide(Field other) => Divide(left: this, right: other);
  Modulo modulo(Field other) => Modulo(left: this, right: other);
}
