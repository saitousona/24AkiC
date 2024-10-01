package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import DBConnector.DBConnector;

public class CreateUserDAO {

    // ユーザーを作成するメソッド
    public boolean createUser(String email, String userName, String password, String secretWord) throws ClassNotFoundException, SQLException {
        Connection connection = null;
        PreparedStatement pstmt = null;
        boolean result = false;

        try {
            connection = DBConnector.getConnection();

            String sql = "INSERT INTO USERS (email, user_name, password, old_password, secret_word) VALUES (?, ?, ?, null, ?)";
            pstmt = connection.prepareStatement(sql);
            pstmt.setString(1, email);
            pstmt.setString(2, userName);
            pstmt.setString(3, password); // 暗号化は後で追加可能
            pstmt.setString(4, secretWord);

            int rowsInserted = pstmt.executeUpdate();
            if (rowsInserted > 0) {
                result = true;
            }
        } finally {
            if (pstmt != null) {
                pstmt.close();
            }
            if (connection != null) {
                connection.close();
            }
        }

        return result;
    }
}
