package ticket;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import bean.MainToDoBean;
import dao.TicketDetailDAO;

public class GetTicketDetailServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String ticketIdParam = request.getParameter("id");

        // チケットIDが正しいか確認
        if (ticketIdParam == null || !ticketIdParam.matches("\\d+")) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "無効なチケットIDです。");
            return;
        }
        
        int ticketId = Integer.parseInt(ticketIdParam);
        TicketDetailDAO dao = new TicketDetailDAO();
        
        try {
            MainToDoBean ticket = dao.getTicketDetailById(ticketId); // チケット詳細を取得
            if (ticket != null) {
                request.setAttribute("ticket", ticket);
                RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/JSP/TicketDetail.jsp"); // チケット詳細用のJSPにフォワード
                dispatcher.forward(request, response);
            } else {
                response.sendError(HttpServletResponse.SC_NOT_FOUND, "チケットが見つかりませんでした。");
            }
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "サーバーエラーが発生しました。");
        }
    }
}
