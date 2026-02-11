import 'package:frida_query_builder/src/query/operators/plus.dart';
import 'package:frida_query_builder/src/query/operators/minus.dart';
import 'package:frida_query_builder/src/query/operators/multiply.dart';
import 'package:frida_query_builder/src/query/operators/divide.dart';
import 'package:frida_query_builder/src/query/operators/modulo.dart';

/// Represents a field in a database table.
class Field {
  /// The name of the field.
  String field;

  /// Optional alias for the field.
  String? alias;

  Field(this.field, {this.alias});

  /// Sets an [alias] for this field.
  Field as(String alias) {
    this.alias = alias;
    return this;
  }

  @override
  String toString() => field;

  // Arithmetic operators

  /// Creates a [Plus] operator: `this + other`.
  Plus plus(Field other) => Plus(left: this, right: other);

  /// Creates a [Minus] operator: `this - other`.
  Minus minus(Field other) => Minus(left: this, right: other);

  /// Creates a [Multiply] operator: `this * other`.
  Multiply multiply(Field other) => Multiply(left: this, right: other);

  /// Creates a [Divide] operator: `this / other`.
  Divide divide(Field other) => Divide(left: this, right: other);

  /// Creates a [Modulo] operator: `this % other`.
  Modulo modulo(Field other) => Modulo(left: this, right: other);
}
