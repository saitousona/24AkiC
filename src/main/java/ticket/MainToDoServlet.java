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

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");
        response.setCharacterEncoding("UTF-8");
    	

        // セッションからemailを取得
        HttpSession session = request.getSession();
        String email = (String) session.getAttribute("email");
        System.out.println("MainToDoServletで取得" + email);

        if (email == null || email.isEmpty()) {
            // emailがセッションにない場合、ログインページにリダイレクト
            response.sendRedirect("TopPageServlet");
            return;
        }

        MainToDoDAO mainToDoDAO = new MainToDoDAO();
        String userName = null;

        try {
            // ユーザー名を取得
            userName = mainToDoDAO.getUserNameByEmail(email);
            
            // ユーザー名をリクエストスコープに設定
            request.setAttribute("userName", userName);
            System.out.println(userName + "を登録しました");

            // チケットを取得
            List<MainToDoBean> userTickets = mainToDoDAO.getTicketsByUserEmail(email);
            System.out.println("チケットをサーブレットで取得できました");

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
            e.printStackTrace();
            response.sendRedirect("error.jsp");
            return;
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
