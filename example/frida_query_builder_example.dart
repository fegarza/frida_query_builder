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
          GreaterThan(Length("name".field), 1),
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
          )
        ],
      ),
    ],
    where: [
      Not([LessThan(Length("transactions.title"), 15)]),
      And([
        Between("transactions.amount".field.plus(10.field), 40, 100),
        Between("transactions.amount".field, 40, 100),
      ]),
    ],
    groupBy: ["contacts.name"],
    limit: 10,
  );

  print(FridaQueryBuilder(query).build() + "\n");

// Arithmetic Operators
  print("=== Arithmetic Operators Examples ===\n");

  // Calculate total with tax
  final orderQuery = Select(
    from: "orders",
    columns: [
      "product_name".field,
      "price".field,
      "quantity".field,
      "price".field.multiply("quantity".field).as("subtotal"),
      "price"
          .field
          .multiply("quantity".field)
          .multiply("tax_rate".field)
          .as("tax"),
      "price"
          .field
          .multiply("quantity".field)
          .plus("price"
              .field
              .multiply("quantity".field)
              .multiply("tax_rate".field))
          .as("total"),
    ],
  );
  print(FridaQueryBuilder(orderQuery).build() + "\n");

  // Calculate average price
  final avgQuery = Select(
    from: "products",
    columns: [
      "total_revenue".field.divide("total_sales".field).as("avg_price"),
    ],
  );
  print(FridaQueryBuilder(avgQuery).build() + "\n");

  // Modulo example for pagination
  final paginationQuery = Select(
    from: "items",
    columns: [
      "id".field,
      "id".field.modulo(Field("10")).as("page_position"),
    ],
  );
  print(FridaQueryBuilder(paginationQuery).build() + "\n");

// Delete
  final deleteContact = Delete(
    table: "contacts",
    criteria: [
      Equals("name".field, "Felipe"),
    ],
  );

  print(FridaQueryBuilder(deleteContact).build() + "\n");
}
