package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import DBConnector.DBConnector;
import bean.UsersBean;

public class LoginDAO {
    public UsersBean authenticate(String userId, String password) throws SQLException, ClassNotFoundException {
        UsersBean user = null;
        Connection connection = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            // データベース接続の取得
            connection = DBConnector.getConnection();

            // SQLクエリでユーザー情報を検索
            String sql = "SELECT * FROM users WHERE user_id = ? AND password = ?";
            pstmt = connection.prepareStatement(sql);
            pstmt.setString(1, userId);
            pstmt.setString(2, password);

            rs = pstmt.executeQuery();

            // ユーザーが存在する場合、UserBeanに情報をセット
            if (rs.next()) {
                user = new UsersBean();
                user.setUserId(rs.getString("user_id"));
                user.setUserName(rs.getString("user_name"));
            }
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace(); // コンソールにエラーメッセージを出力
            throw e; // エラーを呼び出し元に再スロー
        } finally {
            // リソースを閉じる
            if (rs != null) rs.close();
            if (pstmt != null) pstmt.close();
            if (connection != null) connection.close();
        }

        return user;
    }
}
