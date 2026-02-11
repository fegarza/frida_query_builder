import 'package:frida_query_builder/frida_query_builder.dart';

void main() {
  // 1. Create tables
  final contactsTable = Create(tableName: "contacts").addColumns([
    ColumnInteger(
      name: "id",
      isPrimaryKey: true,
      isAutoIncrement: true,
    ),
    ColumnText(
      name: "name",
      isNotNull: true,
      checkConstraints: [
        Length("name".f).greaterThan(1),
      ],
    ),
    ColumnText(name: "email"),
  ]);

  final transactionsTable = Create(tableName: "transactions").addColumns([
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
    ColumnText(
      name: "description",
    ),
    ColumnInteger(
      name: "contact_id",
      foreignKey: ForeignKey(
        referencedTable: "contacts",
        referencedColumn: "id",
      ),
    ),
  ]);

  print(contactsTable.build() + "\n");
  print(transactionsTable.build() + "\n");

  // 2. Alter table
  var alterTable = AddColumn(
    "contacts",
    ColumnText(name: "phone"),
  );
  print(alterTable.build() + "\n");

  // 3. Insert data
  final insertContact = Insert(into: "contacts", values: {})
      .addValue("name", "Felipe")
      .addValue("email", "felipe@example.com")
      .addValue("phone", "123456789");

  final insertTransaction = Insert(into: "transactions", values: {})
      .addValue("title", "Payment")
      .addValue("amount", 100.0)
      .addValue("contact_id", 1);

  print(insertContact.build() + "\n");
  print(insertTransaction.build() + "\n");

  // 4. Select with join, grouping and filters
  final query = Select(from: "transactions")
      .setColumns([
        "transactions.title".f.as("title"),
        "transactions.amount".f,
        "contacts.name".f,
      ])
      .addJoin(
        Join(
          "contacts",
          type: JoinType.inner,
          criteria: [
            "transactions.contact_id"
                .f
                .equals("contacts.id".f, valueQuoted: false)
          ],
        ),
      )
      .where([
        Length("title".f).lessThan(15).not(),
        ("transactions.amount".f.plus(10.f)).between(40, 100) &
            "transactions.amount".f.between(40, 100),
      ])
      .groupByColumns(["contacts.name"])
      .setLimit(10);

  print(query.build() + "\n");

  // 5. Arithmetic Operators
  print("=== Arithmetic Operators Examples ===\n");

  // Calculate total with tax
  final orderQuery = Select(from: "orders").setColumns([
    "product_name".f,
    "price".f,
    "quantity".f,
    "price".f.multiply("quantity".f).as("subtotal"),
    "price".f.multiply("quantity".f).multiply("tax_rate".f).as("tax"),
    "price"
        .f
        .multiply("quantity".f)
        .plus("price".f.multiply("quantity".f).multiply("tax_rate".f))
        .as("total"),
  ]);
  print(orderQuery.build() + "\n");

  // Calculate average price
  final avgQuery = Select(from: "products").setColumns([
    "total_revenue".f.divide("total_sales".f).as("avg_price"),
  ]);
  print(avgQuery.build() + "\n");

  // Modulo example for pagination
  final paginationQuery = Select(from: "items").setColumns([
    "id".f,
    "id".f.modulo(10.f).as("page_position"),
  ]);
  print(paginationQuery.build() + "\n");

  // 6. Delete
  final deleteContact =
      Delete(table: "contacts").where(["name".f.equals("Felipe")]);

  print(deleteContact.build() + "\n");
}
