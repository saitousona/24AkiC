package ticket;

import java.io.IOException;
import java.sql.Date;
import java.sql.SQLException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import bean.MainToDoBean;
import dao.TicketOperationDAO;

public class FixOrCreateTicketServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");
        response.setCharacterEncoding("UTF-8");
        
        String action = request.getParameter("action");
        System.out.println("Action: " + action); 

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
        
        String userEmail = (String) request.getParameter("email");
        System.out.println("Emailは取れてるかな？" + userEmail);

        TicketOperationDAO ticketDAO = new TicketOperationDAO();

        System.out.println(ticketId + title + deadline + assignedPerson + importance + progress + category + userEmail);
        try {
            String redirectPage = ""; 
            
            if ("update".equals(action)) {
                System.out.println("Action is update");
                MainToDoBean bean = new MainToDoBean(ticketId, title, deadline, assignedPerson, importance, progress, category, userEmail);
                ticketDAO.updateTicket(bean);
            } else if ("create".equals(action)) {
                System.out.println("Action is create");
                MainToDoBean newTicket = new MainToDoBean(ticketId, title, deadline, assignedPerson, importance, progress, category, userEmail);
                ticketDAO.insertTicket(newTicket);
            }
            
            HttpSession session = request.getSession();
            String currentPage = (String) session.getAttribute("currentPage"); // セッションから属性を取得
            System.out.println("現在のページ: " + currentPage);


            // currentPage に基づいてリダイレクト先を設定
            if (currentPage != null) {
                if (currentPage.contains("MainToDoServlet")) {
                    redirectPage = "MainToDoServlet";
                } else if (currentPage.contains("ImportanceToDoServlet")) {
                    redirectPage = "ImportanceToDoServlet";
                } else {
                    redirectPage = "MainToDoServlet"; 
                }
            } else {
                redirectPage = "MainToDoServlet"; 
            }

            System.out.println("リダイレクト先のページ: " + redirectPage);

            List<MainToDoBean> tickets = ticketDAO.getAllTickets();
            request.setAttribute("tickets", tickets);
            
            RequestDispatcher dispatcher = request.getRequestDispatcher(redirectPage);
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

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }
}
