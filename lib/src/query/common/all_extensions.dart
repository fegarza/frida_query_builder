import 'package:frida_query_builder/frida_query_builder.dart';

extension FridaString on String {
  Field get field => Field(this);
  Field get f => Field(this);
}

extension FridaInt on int {
  Field get field => Field(toString());
  Field get f => Field(toString());
}

extension FridaDouble on double {
  Field get field => Field(toString());
  Field get f => Field(toString());
}
