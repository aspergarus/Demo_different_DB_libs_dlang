import ddbc;
import std.stdio;
import std.conv;

struct DDBCDemo {
    static void runDemo() {

        // provide URL for proper type of DB
        // string url = "postgresql://localhost:5432/ddbctestdb?user=ddbctest,password=ddbctestpass,ssl=true";
        // string url = "mysql://localhost:3306/ddbctestdb?user=ddbctest,password=ddbctestpass";
        string url = "sqlite:ddbc_demo.sqlite";

        // creating Connection
        auto conn = createConnection(url);
        scope(exit) conn.close();

        // creating Statement
        auto stmt = conn.createStatement();
        scope(exit) stmt.close();

        // execute simple queries to create and fill table
        stmt.executeUpdate("DROP TABLE IF EXISTS ddbct1");
        stmt.executeUpdate("CREATE TABLE IF NOT EXISTS ddbct1 (
            id INTEGER not null primary key AUTOINCREMENT, 
            name varchar(250),
            comment text,
            ts datetime
        )");
        stmt.executeUpdate("INSERT INTO ddbct1 (name, comment, ts) VALUES
                            ('name1', 'comment for line 1', '2016/09/14 15:24:01')");
        stmt.executeUpdate("INSERT INTO ddbct1 (name, comment) VALUES
                            ('name2', 'comment for line 2 - can be very long')");
        stmt.executeUpdate("INSERT INTO ddbct1 (name) values('name3')"); // comment is null here

        // reading DB
        // auto rs = stmt.executeQuery("SELECT id, name name_alias, comment, ts FROM ddbct1 ORDER BY id");
        auto rs = stmt.executeQuery("SELECT * FROM ddbct1 ORDER BY id");
        while (rs.next()) {
            writeln(to!string(rs.getLong(1)), "\t", rs.getString(2), "\t", rs.getString(3), "\t", rs.getString(4));
        }
    }
}
