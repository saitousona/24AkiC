package ticket;

import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import bean.MainToDoBean;
import dao.MainToDoDAO;

public class MainToDoServlet extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // セッションからemailを取得
        HttpSession session = request.getSession();
        String email = (String) session.getAttribute("email");

        if (email == null || email.isEmpty()) {
            // emailがセッションにない場合、ログインページにリダイレクト
            response.sendRedirect("login.jsp");
            return;
        }

        // チケットを取得するためDAOを使用
        MainToDoDAO mainToDoDAO = new MainToDoDAO();
        List<MainToDoBean> userTickets;
		try {
			userTickets = mainToDoDAO.getTicketsByUserEmail(email);
		

        // 進捗状況ごとにチケットを分類
        List<MainToDoBean> notStartedTickets = new ArrayList<>();
        List<MainToDoBean> inProgressTickets = new ArrayList<>();
        List<MainToDoBean> completedTickets = new ArrayList<>();

        for (MainToDoBean ticket : userTickets) {
            if (ticket.getProgress() == 0) {
                notStartedTickets.add(ticket);
            } else if (ticket.getProgress() < 100) {
                inProgressTickets.add(ticket);
            } else {
                completedTickets.add(ticket);
            }
        }
        

        // リクエストスコープにチケットを設定
        request.setAttribute("notStartedTickets", notStartedTickets);
        request.setAttribute("inProgressTickets", inProgressTickets);
        request.setAttribute("completedTickets", completedTickets);
		} catch (SQLException e) {
			// TODO 自動生成された catch ブロック
			e.printStackTrace();
		}
        // JSPにフォワード
        RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/JSP/MainToDoPage.jsp");
        dispatcher.forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}
