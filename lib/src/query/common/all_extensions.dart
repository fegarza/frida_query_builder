import 'package:frida_query_builder/frida_query_builder.dart';

/// Extensions for [String] to easily create [Field] objects.
extension FridaString on String {
  /// Converts the string to a [Field].
  Field get field => Field(this);

  /// Shorthand to convert the string to a [Field].
  Field get f => Field(this);

  /// Returns a [CurrentTimestamp] instance.
  CurrentTimestamp get currentTimestamp => CurrentTimestamp();
}

/// Extensions for [int] to easily create [Field] objects (useful for numeric fields).
extension FridaInt on int {
  /// Converts the integer to a [Field] (as a string).
  Field get field => Field(toString());

  /// Shorthand to convert the integer to a [Field] (as a string).
  Field get f => Field(toString());
}

/// Extensions for [double] to easily create [Field] objects (useful for numeric fields).
extension FridaDouble on double {
  /// Converts the double to a [Field] (as a string).
  Field get field => Field(toString());

  /// Shorthand to convert the double to a [Field] (as a string).
  Field get f => Field(toString());
}
