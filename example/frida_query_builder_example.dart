import 'package:frida_query_builder/frida_query_builder.dart';

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

  print(contactsTable.build() + "\n");
  print(transactionsTable.build() + "\n");

  var alterTable = AddColumn(
    "contacts",
    ColumnText(name: "phone"),
  );
  print(FridaQueryBuilder(alterTable).build() + "\n");

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
      "transactions.title".field.as("title"),
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
