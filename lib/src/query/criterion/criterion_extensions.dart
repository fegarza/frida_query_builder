import 'package:frida_query_builder/frida_query_builder.dart';

/// Extensions for [Field] to create [Criterion] objects fluently.
extension FieldExtensions on Field {
  /// Creates an [Equals] criterion: `this = value`.
  Equals equals(Object? value, {bool? valueQuoted}) =>
      Equals(this, value, secondFieldQuoted: valueQuoted ?? !(value is Field));

  /// Creates a [NotEquals] criterion: `this <> value`.
  NotEquals notEquals(Object? value, {bool? valueQuoted}) =>
      NotEquals(this, value,
          secondFieldQuoted: valueQuoted ?? !(value is Field));

  /// Creates a [GreaterThan] criterion: `this > value`.
  GreaterThan greaterThan(Object? value) => GreaterThan(this, value);

  /// Creates a [GreaterEqualThan] criterion: `this >= value`.
  GreaterEqualThan greaterEqualThan(Object? value) =>
      GreaterEqualThan(this, value);

  /// Creates a [LessThan] criterion: `this < value`.
  LessThan lessThan(Object? value) => LessThan(this, value);

  /// Creates a [LessEqualThan] criterion: `this <= value`.
  LessEqualThan lessEqualThan(Object? value) => LessEqualThan(this, value);

  /// Creates a [Like] criterion: `this LIKE value`.
  Like like(Object? value) => Like(this, value);

  /// Creates a [Between] criterion: `this BETWEEN start AND end`.
  Between between(Object? start, Object? end) => Between(this, start, end);

  /// Creates an [In] criterion: `this IN (values)`.
  In isIn(List<Object> values) => In(this, values);
}

/// Extensions for [Criterion] to combine them using logical operators.
extension FridaCriteriaExtensions on Criterion {
  /// Combines two criteria with an [And] operator.
  And operator &(Criterion other) => And([this, other]);

  /// Combines two criteria with an [Or] operator.
  Or operator |(Criterion other) => Or([this, other]);

  /// Negates the criterion with a [Not] operator.
  Not not() => Not([this]);
}
