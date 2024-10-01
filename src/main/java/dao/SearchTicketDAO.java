package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import DBConnector.DBConnector;
import bean.MainToDoBean; // Ticketクラスをインポート

public class SearchTicketDAO {

    // 検索条件に基づくチケットを取得
    public List<MainToDoBean> searchTickets(String email, String criteria, String searchText) throws ClassNotFoundException {
    	System.out.println("searchTicketsメソッド内のローカル変数" + email + criteria + searchText);
        List<MainToDoBean> tickets = new ArrayList<>();
        String query = "SELECT * FROM TICKET WHERE email = ?  AND " + criteria + " LIKE ?";

        try (Connection conn = DBConnector.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {
        	stmt.setString(1, email);
            stmt.setString(2, "%" + searchText + "%");
            
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    tickets.add(mapTicket(rs)); // Ticketオブジェクトへのマッピング
                    System.out.println("検索の実行");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace(); // エラーハンドリングの改善を検討
        }
        System.out.println("チケットのりたーん" + tickets);
        return tickets;
    }

    // ユーザーに紐づくすべてのチケットを取得
    public List<MainToDoBean> getAllTicketsByUser(String email) throws ClassNotFoundException {
        List<MainToDoBean> tickets = new ArrayList<>();
        String query = "SELECT * FROM TICKET WHERE email = ?";

        try (Connection conn = DBConnector.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setString(1, email);

            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    tickets.add(mapTicket(rs)); // Ticketオブジェクトへのマッピング
                }
            }
        } catch (SQLException e) {
            e.printStackTrace(); // エラーハンドリングの改善を検討
        }
        return tickets;
    }

    // ResultSetからTicketオブジェクトを生成
    private MainToDoBean mapTicket(ResultSet rs) throws SQLException {
        MainToDoBean ticket = new MainToDoBean();
        ticket.setTicketId(rs.getInt("TICKET_ID"));
        ticket.setTitle(rs.getString("TITLE"));
        ticket.setDeadline(rs.getDate("DEADLINE"));
        ticket.setAssignedPerson(rs.getString("ASSIGNED_PERSON"));
        ticket.setImportance(rs.getString("IMPORTANCE"));
        ticket.setProgress(rs.getInt("PROGRESS"));
        ticket.setCategory(rs.getString("CATEGORY"));
        return ticket;
    }

}
