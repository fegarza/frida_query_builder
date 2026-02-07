<p align="center">
  <img src='https://i.imgur.com/tJRrDrh.png' width='250px'/>
</p>

# 🔨 Frida query builder

Frida Query Builder is a lightweight Dart library designed to build basic SQLite queries in a clear and structured way, without code generators, without heavy ORMs, and without complex configurations.

Its goal is to provide a minimal abstraction layer that allows developers to create SELECT, INSERT, UPDATE, and DELETE statements using Dart classes and methods, while keeping full control over the generated SQL.

**Frida is built for developers who:**

- Want explicit and predictable SQL
- Do not need automatic migrations or generated models
- Prefer simplicity over feature-heavy ORMs
- Work with SQLite in local applications (Flutter or pure Dart)

Frida Query Builder does not try to hide SQL—instead, it makes it more readable, reusable, and safer, reducing common string-concatenation errors and improving code maintainability.

## Examples

DDL

```dart

final createUsers = Create(
    tableName: "users",
    columns: [
      ColumnInteger(
        name: "id",
        isPrimaryKey: true,
        isAutoIncrement: true,
      ),
      ColumnText(
        name: "name",
        isNotNull: true,
      ),
    ],
  );
  print(FridaQueryBuilder(createUsers).build());

  /* Output:
  CREATE TABLE users(
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL
  );
  */
```

DQL

```dart

final createUsers = Create(
    tableName: "users",
    columns: [
      ColumnInteger(
        name: "id",
        isPrimaryKey: true,
        isAutoIncrement: true,
      ),
      ColumnText(
        name: "name",
        isNotNull: true,
      ),
    ],
  );
  print(FridaQueryBuilder(createUsers).build());

  /* Output:
  CREATE TABLE users(
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL
  );
  */
```

DML

```dart
// Insert
final insertUser = Insert(
  into: "users",
  values: {
    "name": "Felipe",
  },
);

print(FridaQueryBuilder(insertUser).build());

  /* Output:
  INSERT INTO users(name) VALUES("Felipe");
  */
```

DQL

```dart
// Select
final selectUsers = Select(
  from: "users",
  columns: ["id".field, "name".field],
);


print(FridaQueryBuilder(selectUsers).build());

  /* Output:
  INSERT INTO users(name) VALUES("Felipe");
  */
```

## 📖 Supported SQLite Functionalities

**Data types**

| Functionality | Supported |
| ------------- | --------- |
| INTEGER       | ✅        |
| REAL          | ✅        |
| TEXT          | ✅        |
| BLOB          | ✅        |

**Data definition**

| Functionality                    | Supported |
| -------------------------------- | --------- |
| CREATE TABLE                     | ✅        |
| DROP TABLE                       | ❌        |
| ALTER TABLE (rename, add column) | ❌        |

**Data Manipulation**

| Functionality               | Supported |
| --------------------------- | --------- |
| INSERT INTO (single row)    | ✅        |
| INSERT INTO (multiple rows) | ❌        |
| UPDATE (with WHERE)         | ✅        |
| DELETE (with WHERE)         | ✅        |

**Querying (SELECT)**

| Functionality                                   | Supported |
| ----------------------------------------------- | --------- |
| SELECT (specific columns / \*)                    | ✅        |
| DISTINCT                                        | ✅        |
| WHERE conditions                                | ✅        |
| ORDER BY                                        | ✅        |
| GROUP BY + HAVING                               | ✅        |
| LIMIT + OFFSET                                  | ✅        |
| INNER JOIN                                      | ✅        |
| LEFT JOIN                                       | ✅        |
| Subqueries (WHERE, FROM, SELECT)                | ❌        |
| Aggregate functions (COUNT, SUM, AVG, MIN, MAX) | ✅        |

**Constraints & Expr.**

| Functionality                              | Supported |
| ------------------------------------------ | --------- |
| CHECK                                      | ✅        |
| NOT NULL                                   | ❌        |
| DEFAULT                                    | ✅        |
| UNIQUE                                     | ❌        |
| PRIMARY KEY                                | ✅        |
| FOREIGN KEY                                | ✅        |
| Arithmetic operators (+, -, \*, /)         | ❌        |
| Comparison operators (=, <>, <, <=, >, >=) | ✅        |
| AND                                        | ✅        |
| OR                                         | ✅        |
| NOT                                        | ❌        |
| IN                                         | ✅        |
| BETWEEN                                    | ❌        |
| LIKE                                       | ✅        |

**Transactions**

| Functionality     | Supported |
| ----------------- | --------- |
| BEGIN TRANSACTION | ❌        |
| COMMIT            | ❌        |
| ROLLBACK          | ❌        |
| CREATE INDEX      | ❌        |
| DROP INDEX        | ❌        |
| Unique indexes    | ❌        |

**Advanced**

| Functionality           | Supported |
| ----------------------- | --------- |
| WITH (CTE)              | ❌        |
| Window functions        | ❌        |
| Full-text search (FTS5) | ❌        |
| JSON functions          | ❌        |

## 📄 UML Diagram classes

<details>
<summary>Statements classes</summary>
<img src="https://raw.githubusercontent.com/fegarza/frida_query_builder/main/out/uml/statementClasses/statement_classes.png"/>
</details>
<details>
<summary>Builders classes</summary>
<img src="https://raw.githubusercontent.com/fegarza/frida_query_builder/main/out/uml/buildersClasses/builder_classes.png"/>
</details>

