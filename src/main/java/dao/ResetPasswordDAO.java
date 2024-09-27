package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import DBConnector.DBConnector;

public class ResetPasswordDAO {

    // ユーザーの認証
    public boolean validateUser(String email, String secretWord) throws ClassNotFoundException {
        String sql = "SELECT COUNT(*) FROM USERS WHERE email = ? AND secret_word = ?";
        try (Connection conn = DBConnector.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, email);
            pstmt.setString(2, secretWord);
            ResultSet rs = pstmt.executeQuery();
            rs.next();
            return rs.getInt(1) > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    // 現在のパスワードを取得
    public String getCurrentPassword(String email) throws ClassNotFoundException {
        String sql = "SELECT password FROM USERS WHERE email = ?";
        try (Connection conn = DBConnector.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, email);
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                return rs.getString("password");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    // 一世代前のパスワードを取得
    public String getOldPassword(String email) throws ClassNotFoundException {
        String sql = "SELECT old_password FROM USERS WHERE email = ?";
        try (Connection conn = DBConnector.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, email);
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                return rs.getString("old_password");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    // パスワードを更新
    public void updatePassword(String email, String newPassword, String currentPassword) throws ClassNotFoundException {
        String sql = "UPDATE USERS SET password = ?, old_password = ? WHERE email = ?";
        try (Connection conn = DBConnector.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, newPassword);
            pstmt.setString(2, currentPassword); // 現在のパスワードをold_passwordに保存
            pstmt.setString(3, email);
            pstmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
