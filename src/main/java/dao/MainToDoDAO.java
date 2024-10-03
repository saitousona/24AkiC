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

    // ユーザーの全チケットを取得するメソッド
    public List<MainToDoBean> getTicketsByUserEmail(String email) throws SQLException {
        List<MainToDoBean> tickets = new ArrayList<>();
        String sql = "SELECT * FROM Ticket WHERE EMAIL = ? ORDER BY DEADLINE";

        try {
            connection = DBConnector.getConnection();
            PreparedStatement preparedStatement = connection.prepareStatement(sql);
            preparedStatement.setString(1, email);

            ResultSet resultSet = preparedStatement.executeQuery();
            while (resultSet.next()) {
                int ticketId = resultSet.getInt("TICKET_ID");
                String title = resultSet.getString("TITLE");
                java.sql.Date deadline = resultSet.getDate("DEADLINE");
                String assignedPerson = resultSet.getString("ASSIGNED_PERSON");
                String importance = resultSet.getString("IMPORTANCE");
                int progress = resultSet.getInt("PROGRESS");
                String category = resultSet.getString("CATEGORY");

                MainToDoBean ticket = new MainToDoBean(ticketId, title, deadline, assignedPerson, importance, progress, category, email);
                tickets.add(ticket);
            }
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            if (connection != null) {
                connection.close();
            }
        }

        return tickets;
    }

    // 検索条件に基づいてチケットを取得するメソッド
    public List<MainToDoBean> searchTickets(String email, Integer progress, String category, String importance) throws SQLException {
        List<MainToDoBean> tickets = new ArrayList<>();
        StringBuilder sql = new StringBuilder("SELECT * FROM Ticket WHERE EMAIL = ?");

        if (progress != null) {
            sql.append(" AND PROGRESS = ?");
        }
        if (category != null && !category.isEmpty()) {
            sql.append(" AND CATEGORY = ?");
        }
        if (importance != null && !importance.isEmpty()) {
            sql.append(" AND IMPORTANCE = ?");
        }
        sql.append(" ORDER BY DEADLINE");

        try {
            connection = DBConnector.getConnection();
            PreparedStatement preparedStatement = connection.prepareStatement(sql.toString());
            preparedStatement.setString(1, email);

            int paramIndex = 2;
            if (progress != null) {
                preparedStatement.setInt(paramIndex++, progress);
            }
            if (category != null && !category.isEmpty()) {
                preparedStatement.setString(paramIndex++, category);
            }
            if (importance != null && !importance.isEmpty()) {
                preparedStatement.setString(paramIndex++, importance);
            }

            ResultSet resultSet = preparedStatement.executeQuery();
            while (resultSet.next()) {
                int ticketId = resultSet.getInt("TICKET_ID");
                String title = resultSet.getString("TITLE");
                java.sql.Date deadline = resultSet.getDate("DEADLINE");
                String assignedPerson = resultSet.getString("ASSIGNED_PERSON");
                String importanceValue = resultSet.getString("IMPORTANCE");
                int progressValue = resultSet.getInt("PROGRESS");
                String categoryValue = resultSet.getString("CATEGORY");

                MainToDoBean ticket = new MainToDoBean(ticketId, title, deadline, assignedPerson, importanceValue, progressValue, categoryValue, email);
                tickets.add(ticket);
            }
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            if (connection != null) {
                connection.close();
            }
        }

        return tickets;
    }
    
 // ユーザー名を取得するメソッド
    public String getUserNameByEmail(String email) throws SQLException {
        String userName = null;
        String sql = "SELECT name FROM Users WHERE email = ?";

        try {
            connection = DBConnector.getConnection();
            PreparedStatement preparedStatement = connection.prepareStatement(sql);
            preparedStatement.setString(1, email);

            ResultSet resultSet = preparedStatement.executeQuery();
            if (resultSet.next()) {
                userName = resultSet.getString("name");
            }
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            if (connection != null) {
                connection.close();
            }
        }

        return userName;
    }

}
