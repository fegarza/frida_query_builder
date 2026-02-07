import 'package:frida_query_builder/frida_query_builder.dart';
import 'package:frida_query_builder/src/query/common/statement.dart';
import 'package:frida_query_builder/src/query/create/column/column_blob.dart';
import 'package:frida_query_builder/src/query/create/column/column_integer.dart';
import 'package:frida_query_builder/src/query/create/column/column_real.dart';
import 'package:frida_query_builder/src/query/create/column/column_text.dart';
import 'package:frida_query_builder/src/query/create/foreign_key.dart';
import 'package:frida_query_builder/src/query/criterion/criterion_login.dart';
import 'package:frida_query_builder/src/query/criterion/operators/greater_equal_than.dart';
import 'package:frida_query_builder/src/query/criterion/operators/greater_than.dart';
import 'package:frida_query_builder/src/query/criterion/operators/grouping.dart';
import 'package:frida_query_builder/src/query/functions/length.dart';

void main() {
  // Create tables
  final contactsTable = Create(
    tableName: "contacts",
    columns: [
      ColumnInteger(
        name: "id",
        isPrimaryKey: true,
        isAutoIncrement: true,
      ),
      ColumnText(
        name: "name",
        isNotNull: true,
        checkConstraints: [
          GreaterThan(Length("name"), 1),
        ],
      ),
      ColumnText(name: "email"),
    ],
  );

  final transactionsTable = Create(
    tableName: "transactions",
    columns: [
      ColumnInteger(
        name: "id",
        isPrimaryKey: true,
        isAutoIncrement: true,
      ),
      ColumnText(
        name: "title",
        isNotNull: true,
      ),
      ColumnReal(
        name: "amount",
        isNotNull: true,
      ),
      ColumnInteger(
        name: "contact_id",
        foreignKey: ForeignKey(
          referencedTable: "contacts",
          referencedColumn: "id",
        ),
      ),
    ],
  );

  print(FridaQueryBuilder(contactsTable).build() + "\n");
  print(FridaQueryBuilder(transactionsTable).build() + "\n");

// Insert data
  final insertContact = Insert(
    into: "contacts",
    values: {
      "name": "Felipe",
      "email": "f@f.com",
    },
  );

  final insertTransaction = Insert(
    into: "transactions",
    values: {
      "title": "Payment",
      "amount": 100.0,
      "contact_id": 1,
    },
  );

  print(FridaQueryBuilder(insertContact).build() + "\n");
  print(FridaQueryBuilder(insertTransaction).build() + "\n");

// Select with join, grouping and filters
  final query = Select(
    from: "transactions",
    columns: [
      "transactions.title".field,
      "transactions.amount".field,
      "contacts.name".field,
    ],
    joins: [
      Join(
        "contacts",
        type: JoinType.inner,
        criteria: [
          Equals(
            "transactions.contact_id".field,
            "contacts.id".field,
          ),
        ],
      ),
    ],
    where: [
      GreaterThan("transactions.amount".field, 50),
    ],
    groupBy: ["contacts.name"],
    limit: 10,
  );

  print(FridaQueryBuilder(query).build() + "\n");

// Delete
  final deleteContact = Delete(
    table: "contacts",
    criteria: [
      Equals("name".field, "Felipe"),
    ],
  );

  print(FridaQueryBuilder(deleteContact).build() + "\n");
}
