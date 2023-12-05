import 'package:frida_query_builder/frida_query_builder.dart';
import 'package:frida_query_builder/src/query/select/join_query_builder.dart';
import 'package:test/test.dart';

void main() {
  group("JoinQueryBuilder: ", () {
    test(
      "'ON' condition statemente should be parsed without quoted wrapping fields",
      () {
        final queryBuilder = JoinQueryBuilder(
          Join(
            "user",
            criteria: [
              Equals('user.id', 'address.user_id'),
            ],
          ),
        );

        expect(
          queryBuilder.build(),
          equals(
            "INNER JOIN user \n ON  user.id = address.user_id \n",
          ),
        );
      },
    );
  });
}
