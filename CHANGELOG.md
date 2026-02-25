# 1.2.6

- Fix double quotes in default values.

# 1.2.5

- Fix, 'from' in select statement is not required.

# 1.2.4

- Add support for CREATE TABLE IF NOT EXISTS statement.

# 1.2.3

- Add support for batch insert.
- Add support for FOREIGN KEY - ON UPDATE AND ON DELETE actions.
- Add support for CURRENT_TIMESTAMP function.
- Add support for fluent style definition.
- Add support for CREATE INDEX and DROP INDEX statements.

## 1.2.2

- Fix to use single quotes for string literals in SQL queries (SQL standard compliance).

## 1.2.1

- Fix issue with functions not working when field is a string.

## 1.2.0

- Introduce arithmetic operators (+, -, *, /, %) for field expressions in queries.
- Refactor the code using visitor pattern.
- Add AVG, MAX, MIN, SUM, COUNT aggregate functions.
- Add support for aliasing field expressions.
- Add support for nested field expressions.
- Add support for BETWEEN operator.
- Add support for ALTER TABLE statements.
- Optimize imports and remove unused code.
- Unit testing.