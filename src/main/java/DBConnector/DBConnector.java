package DBConnector;

import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.Properties;


public class DBConnector {
    private static String url;
    private static String user;
    private static String pass;

    static {
        try (InputStream input = DBConnector.class.getClassLoader().getResourceAsStream("resources/db.properties")) {
            if (input == null) {
                throw new RuntimeException("db.properties がクラスパスに存在しません。");
            }
            Properties props = new Properties();
            props.load(input);
            url = props.getProperty("db.url");
            user = props.getProperty("db.user");
            pass = props.getProperty("db.password");
        } catch (IOException e) {
            e.printStackTrace();
            throw new RuntimeException("プロパティファイルの読み込みに失敗しました。");
        }
    }

    public static Connection getConnection() throws ClassNotFoundException, SQLException {
        try {
            Class.forName("oracle.jdbc.driver.OracleDriver"); 
            return DriverManager.getConnection(url, user, pass);
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace(); // エラーの詳細をコンソールに出力
            throw e; // エラーを呼び出し元に再スロー
        }
    }
}
