module d2sqlite3_demo;

import d2sqlite3;
import std.stdio;

struct D2SQLite3_demo {
    static void runDemo() {
        auto db = Database("d2sqlite3_demo.db");
        db.run("DROP TABLE if exists test");
        db.run("CREATE TABLE if not exists test (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            val FLOAT NOT NULL,
            name varchar(250) NOT NULL
        )");

        auto statement = db.prepare("INSERT INTO test (val, name) VALUES (?,?)");
        statement.inject(36, "Clara");
        statement.inject(25, "Maria");
        statement.inject(13, "Alex");
        statement.inject(17, "John");

        auto results = db.execute("SELECT * FROM test");
        foreach (row; results) {
            writeln(row.peek!int("id"));
            writeln(row.peek!int("val"));
            writeln(row.peek!string("name"));
        }
    }
}
