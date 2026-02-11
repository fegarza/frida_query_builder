import 'package:frida_query_builder/frida_query_builder.dart';

extension FieldExtensions on Field {
  Equals equals(Object? value, {bool valueQuoted = true}) =>
      Equals(this, value, secondFieldQuoted: valueQuoted);

  NotEquals notEquals(Object? value, {bool valueQuoted = true}) =>
      NotEquals(this, value, secondFieldQuoted: valueQuoted);

  GreaterThan greaterThan(Object? value) => GreaterThan(this, value);

  GreaterEqualThan greaterEqualThan(Object? value) =>
      GreaterEqualThan(this, value);

  LessThan lessThan(Object? value) => LessThan(this, value);

  LessEqualThan lessEqualThan(Object? value) => LessEqualThan(this, value);

  Like like(Object? value) => Like(this, value);

  Between between(Object? start, Object? end) => Between(this, start, end);

  In isIn(List<Object> values) => In(this, values);
}

extension FridaCriteriaExtensions on Criterion {
  And operator &(Criterion other) => And([this, other]);
  Or operator |(Criterion other) => Or([this, other]);
  Not not() => Not([this]);
}
