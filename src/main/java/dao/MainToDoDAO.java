package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import DBConnector.DBConnector;
import bean.MainToDoBean;

public class MainToDoDAO {
    private Connection connection;

    public List<MainToDoBean> getTicketsByUserEmail(String email) throws SQLException {
        List<MainToDoBean> tickets = new ArrayList<>();
        String sql = "SELECT * FROM Ticket WHERE EMAIL = ? ORDER BY DEADLINE"; // チケット情報の取得

        try {
            connection = DBConnector.getConnection();
            PreparedStatement preparedStatement = connection.prepareStatement(sql);
            preparedStatement.setString(1, email); // プレースホルダーにユーザーのメールを設定

            ResultSet resultSet = preparedStatement.executeQuery();
            while (resultSet.next()) {
                // チケット情報を取得
                int ticketId = resultSet.getInt("TICKET_ID");
                String title = resultSet.getString("TITLE");
                java.sql.Date deadline = resultSet.getDate("DEADLINE");
                String assignedPerson = resultSet.getString("ASSIGNED_PERSON");
                String importance = resultSet.getString("IMPORTANCE");
                int progress = resultSet.getInt("PROGRESS");
                String category = resultSet.getString("CATEGORY");

                // MainToDoBeanに設定
                MainToDoBean ticket = new MainToDoBean(ticketId, title, deadline, assignedPerson, importance, progress, category, email);
                tickets.add(ticket);
            }
        } catch (ClassNotFoundException e) {
        	e.printStackTrace();
        } catch (SQLException e) {
            e.printStackTrace(); // エラーの詳細をコンソールに出力
        } finally {
            if (connection != null) {
                connection.close(); // 接続をクローズ
            }
        }

        return tickets; // チケットリストを返す
    }
}
