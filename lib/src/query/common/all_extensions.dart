import 'package:frida_query_builder/frida_query_builder.dart';

extension FridaString on String {
  Field get field => Field(this);
}

extension FridaInt on int {
  Field get field => Field(toString());
}

extension FridaDouble on double {
  Field get field => Field(toString());
}
