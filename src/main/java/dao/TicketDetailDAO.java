package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import DBConnector.DBConnector;
import bean.MainToDoBean;

public class TicketDetailDAO {
    private Connection connection;

    public MainToDoBean getTicketDetailById(int ticketId) throws SQLException {
        MainToDoBean ticket = null;
        String sql = "SELECT * FROM Ticket WHERE TICKET_ID = ?"; // チケット詳細の取得

        try {
            connection = DBConnector.getConnection();
            PreparedStatement preparedStatement = connection.prepareStatement(sql);
            preparedStatement.setInt(1, ticketId); // プレースホルダーにチケットIDを設定

            ResultSet resultSet = preparedStatement.executeQuery();
            if (resultSet.next()) {
                // チケット情報を取得
                int id = resultSet.getInt("TICKET_ID");
                String title = resultSet.getString("TITLE");
                java.sql.Date deadline = resultSet.getDate("DEADLINE");
                String assignedPerson = resultSet.getString("ASSIGNED_PERSON");
                String importance = resultSet.getString("IMPORTANCE");
                int progress = resultSet.getInt("PROGRESS");
                String category = resultSet.getString("CATEGORY");
                String email = resultSet.getString("EMAIL");

                // MainToDoBeanに設定
                ticket = new MainToDoBean(id, title, deadline, assignedPerson, importance, progress, category, email);
            }
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        } finally {
            if (connection != null) {
                connection.close(); // 接続をクローズ
            }
        }

        return ticket; // チケット詳細を返す
    }
}
