import 'package:frida_query_builder/src/query/common/criteria_statement.dart';
import 'package:frida_query_builder/src/query/criterion/criteria_query_builder.dart';
import 'package:frida_query_builder/src/query/update/update.dart';

class UpdateQueryBuilder extends CriteriaQueryBuilder {
  Update update;

  UpdateQueryBuilder(this.update) : super(update);

  @override
  String build() {
    StringBuffer sb = StringBuffer();

    sb.writeln("UPDATE ${update.source} SET ${_buildSetString()}");

    if (update.criteria.isNotEmpty) {
      sb.writeln("WHERE ${CriteriaQueryBuilder(CriteriaStatement(
        update.source,
        criteria: update.criteria,
      )).build()}");
    }
    return sb.toString();
  }

  String _buildSetString() {
    StringBuffer sb = StringBuffer();
    bool isFirstValue = true;
    update.values.forEach(
      (key, value) {
        if (!isFirstValue) {
          sb.write(",");
        }
        sb.write("$key = $value ");

        isFirstValue = false;
      },
    );
    return sb.toString();
  }
}
