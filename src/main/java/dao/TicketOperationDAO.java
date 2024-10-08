package dao;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import DBConnector.DBConnector;
import bean.MainToDoBean;

public class TicketOperationDAO {
    private DBConnector dbConnector; // DBConnectorのインスタンスを保持

    public TicketOperationDAO() {
        dbConnector = new DBConnector(); // DBConnectorのインスタンスを生成
    }

    // チケットの更新
    public void updateTicket(MainToDoBean ticket) throws SQLException, ClassNotFoundException {
        String sql = "UPDATE Ticket SET TITLE = ?, DEADLINE = ?, ASSIGNED_PERSON = ?, IMPORTANCE = ?, PROGRESS = ?, CATEGORY = ? WHERE TICKET_ID = ?";

        try (Connection conn = dbConnector.getConnection(); // DBConnectorを使って接続
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, ticket.getTitle());
            pstmt.setDate(2, ticket.getDeadline());
            pstmt.setString(3, ticket.getAssignedPerson());
            pstmt.setString(4, ticket.getImportance());
            pstmt.setInt(5, ticket.getProgress());
            pstmt.setString(6, ticket.getCategory());
            pstmt.setInt(7, ticket.getTicketId());

            // デバッグ用の出力
            System.out.println("Updating ticket: " + ticket.getTicketId() + " with values - " +
                               "Title: " + ticket.getTitle() + 
                               ", Deadline: " + ticket.getDeadline() + 
                               ", Assigned Person: " + ticket.getAssignedPerson() + 
                               ", Importance: " + ticket.getImportance() + 
                               ", Progress: " + ticket.getProgress() + 
                               ", Category: " + ticket.getCategory());
            pstmt.executeUpdate();
            System.out.println("Update successful for ticket ID: " + ticket.getTicketId());
        } catch (SQLException e) {
            System.out.println("SQLException in updateTicket: " + e.getMessage());
            e.printStackTrace(); // エラーログを出力
            throw e; // エラーを呼び出し元に再スロー
        }
    }

    // チケットの挿入 動きません
    public void insertTicket(MainToDoBean ticket) throws SQLException, ClassNotFoundException {
        String sql = "INSERT INTO Ticket (TICKET_ID, EMAIL, TITLE, DEADLINE, ASSIGNED_PERSON, IMPORTANCE, PROGRESS, CATEGORY) " +
                     "VALUES (TICKET_Sequence.NEXTVAL, ?, ?, ?, ?, ?, ?, ?)";
        
        System.out.println("SQL Statement:1回目 " + sql);
        System.out.println("Parameters: " + 
                           "Email: " + ticket.getUserEmail() + ", " +
                           "Title: " + ticket.getTitle() + ", " +
                           "Deadline: " + ticket.getDeadline() + ", " +
                           "Assigned Person: " + ticket.getAssignedPerson() + ", " +
                           "Importance: " + ticket.getImportance() + ", " +
                           "Progress: " + ticket.getProgress() + ", " +
                           "Category: " + ticket.getCategory());

        try (Connection conn = dbConnector.getConnection(); 
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
        	conn.setAutoCommit(false);
            // パラメータ設定
            pstmt.setString(1, ticket.getUserEmail());
            pstmt.setString(2, ticket.getTitle());
            pstmt.setDate(3, ticket.getDeadline());
            pstmt.setString(4, ticket.getAssignedPerson());
            pstmt.setString(5, ticket.getImportance());
            pstmt.setInt(6, ticket.getProgress());
            pstmt.setString(7, ticket.getCategory());

            // SQL文とパラメータのログ
            System.out.println("SQL Statement:2回目 " + sql);
            System.out.println("Parameters: " + 
                               "Email: " + ticket.getUserEmail() + ", " +
                               "Title: " + ticket.getTitle() + ", " +
                               "Deadline: " + ticket.getDeadline() + ", " +
                               "Assigned Person: " + ticket.getAssignedPerson() + ", " +
                               "Importance: " + ticket.getImportance() + ", " +
                               "Progress: " + ticket.getProgress() + ", " +
                               "Category: " + ticket.getCategory());

            // 更新の実行
            pstmt.executeUpdate();
            conn.commit(); // 明示的にコミット
            System.out.println("Insert successful");
        } catch (SQLException e) {
            System.out.println("SQLException in insertTicket: " + e.getMessage());
            e.printStackTrace();
            throw e; // 再度例外をスローして上位でキャッチ
        }
    }


    // すべてのチケットを取得
    public List<MainToDoBean> getAllTickets() throws SQLException, ClassNotFoundException {
        List<MainToDoBean> tickets = new ArrayList<>();
        String sql = "SELECT TICKET_ID, TITLE, DEADLINE, ASSIGNED_PERSON, IMPORTANCE, PROGRESS, CATEGORY, EMAIL FROM Ticket";

        try (Connection conn = dbConnector.getConnection(); // DBConnectorを使って接続
             PreparedStatement pstmt = conn.prepareStatement(sql);
             ResultSet rs = pstmt.executeQuery()) {

            while (rs.next()) {
                int ticketId = rs.getInt("TICKET_ID");
                String title = rs.getString("TITLE");
                Date deadline = rs.getDate("DEADLINE");
                String assignedPerson = rs.getString("ASSIGNED_PERSON");
                String importance = rs.getString("IMPORTANCE");
                int progress = rs.getInt("PROGRESS");
                String category = rs.getString("CATEGORY");
                String userEmail = rs.getString("EMAIL");

                // チケットを生成する際に ticketId をコンストラクタに渡す
                MainToDoBean ticket = new MainToDoBean(ticketId, title, deadline, assignedPerson, importance, progress, category, userEmail);
                tickets.add(ticket);
            }
            System.out.println("Retrieved " + tickets.size() + " tickets from the database.");
        } catch (SQLException e) {
            System.out.println("SQLException in getAllTickets: " + e.getMessage());
            e.printStackTrace(); // エラーログを出力
            throw e; // エラーを呼び出し元に再スロー
        }
        return tickets;
    }

    // 次のチケットIDを取得
    public Integer getNextTicketId() throws SQLException, ClassNotFoundException {
        String sql = "SELECT ticket_id_seq.NEXTVAL FROM dual"; // シーケンスから次の値を取得するクエリ
        try (Connection conn = dbConnector.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql);
             ResultSet rs = pstmt.executeQuery()) {
            if (rs.next()) {
                Integer nextId = rs.getInt(1);
                System.out.println("Next ticket ID from sequence: " + nextId);
                return nextId; // シーケンスの次の値を返す
            }
        }
        System.out.println("No next ticket ID found.");
        return null; // 値が取得できなかった場合
    }
    
    public void deleteTicket(String ticketId) throws ClassNotFoundException {
        Connection conn = null;
        PreparedStatement pstmt = null;
        try {
            conn = DBConnector.getConnection();
            String sql = "DELETE FROM Ticket WHERE TICKET_ID = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, ticketId);
            pstmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
