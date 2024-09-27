package ticket;

import java.io.IOException;
import java.sql.Date; // Dateをインポート
import java.sql.SQLException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import bean.MainToDoBean; // Beanクラスのインポート
import dao.TicketOperationDAO; // DAOクラスのインポート

public class FixOrCreateTicketServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");
        response.setCharacterEncoding("UTF-8");
        
        String action = request.getParameter("action");
        System.out.println("Action: " + action); // アクションの確認

        Integer ticketId = null;

        // ticketIdの取得
        if (request.getParameter("ticketId") != null && !request.getParameter("ticketId").isEmpty()) {
            ticketId = Integer.parseInt(request.getParameter("ticketId"));
        }
        
        String title = request.getParameter("title");
        Date deadline = null;
        if (request.getParameter("deadline") != null && !request.getParameter("deadline").isEmpty()) {
            deadline = Date.valueOf(request.getParameter("deadline"));
        }
        
        String assignedPerson = request.getParameter("assignedPerson");
        String importance = request.getParameter("importance");
        String category = request.getParameter("category");
        
        int progress = 0;
        if (request.getParameter("progress") != null && !request.getParameter("progress").isEmpty()) {
            progress = Integer.parseInt(request.getParameter("progress"));
        }
        
        // セッションまたはリクエストからEmailを取得
        String userEmail = (String) request.getParameter("email");

        TicketOperationDAO ticketDAO = new TicketOperationDAO();

        System.out.println(ticketId + title + deadline + assignedPerson + importance + progress + category + userEmail);
        try {
            if ("update".equals(action)) {
            	System.out.println("Action is update");
                MainToDoBean bean = new MainToDoBean(ticketId, title, deadline, assignedPerson, importance, progress, category, userEmail);
                ticketDAO.updateTicket(bean);
            } else if("create".equals(action)) {
            	System.out.println("Action is create");
            	
                MainToDoBean newTicket = new MainToDoBean(ticketId, title, deadline, assignedPerson, importance, progress, category, userEmail);
                try {
                    System.out.println("Insert ticket process started"); // 呼び出し確認
                    ticketDAO.insertTicket(newTicket); // メソッドを呼び出す
                    System.out.println("Insert ticket process finished");
                } catch (Exception e) {
                    e.printStackTrace(); // エラーログを出力
                }
            }

            List<MainToDoBean> tickets = ticketDAO.getAllTickets();
            request.setAttribute("tickets", tickets);
            RequestDispatcher dispatcher = request.getRequestDispatcher("MainToDoServlet");
            dispatcher.forward(request, response);

        } catch (NumberFormatException e) {
            request.setAttribute("error", "入力された値が不正です。");
            RequestDispatcher dispatcher = request.getRequestDispatcher("MainToDoServlet");
            dispatcher.forward(request, response);
        } catch (SQLException e) {
            request.setAttribute("error", "データベースエラーが発生しました。");
            RequestDispatcher dispatcher = request.getRequestDispatcher("MainToDoServlet");
            dispatcher.forward(request, response);
        } catch (Exception e) {
            request.setAttribute("error", "エラーが発生しました。もう一度お試しください。");
            RequestDispatcher dispatcher = request.getRequestDispatcher("MainToDoServlet");
            dispatcher.forward(request, response);
        }
    }
}
