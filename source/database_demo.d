module database_demo;

import
    std.array,
    std.stdio,
	std.datetime,
	std.exception,
	std.meta,
	std.string,
	std.traits,
	std.typecons,
	etc.c.sqlite3,
	database.sqlite.db,
    database.sqlbuilder,
	database.util;

struct User {
    ulong id;
    string name;
	int age;
	string address;

	void show() {
		writeln(id, ":", name, ":", age, ":", address);
	}
}

struct DatabaseDemo
{
    static void runDemo() {
        auto db = SQLite3DB("databaseDemo.db");

        db.exec("DROP TABLE IF EXISTS users");
        db.exec("
            CREATE TABLE IF NOT EXISTS users (
                id INTEGER PRIMARY KEY AUTOINCREMENT,
                name TEXT NOT NULL,
                age INT NOT NULL,
                address CHAR(50) NOT NULL
            );
        ");

        db.exec("INSERT INTO users (name, age, address) VALUES (?, ?, ?)", "Alex", 25, "Test1");
        db.exec("INSERT INTO users (name, age, address) VALUES (?, ?, ?)", "John", 28, "Test2");
        db.exec("INSERT INTO users (name, age, address) VALUES (?, ?, ?)", "Timmy", 31, "Test3");

        User[] users;
        auto q = db.query("SELECT * FROM users");
        while(q.step()) {     
            // auto res = q.get!(int, string, int, string);
            // User u = User(res[0], res[1], res[2], res[3]);
            
            users ~= q.get!User;
        }

        foreach (User user; users)
        {
            user.show();
        }
    }
}
