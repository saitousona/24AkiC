package ticket;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import bean.UsersBean;
import dao.LoginDAO;

public class LoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String userId = request.getParameter("user_id");
        String password = request.getParameter("password");

        UsersBean user = null;
        LoginDAO loginDAO = new LoginDAO();

        try {
            user = loginDAO.authenticate(userId, password);
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace(); // エラーのスタックトレースをコンソールに出力
            request.setAttribute("errorMessage", "システムエラーが発生しました。管理者に連絡してください。");
            request.getRequestDispatcher("/WEB-INF/JSP/ErrorPage.jsp").forward(request, response);
            return;
        }

        if (user != null) {
            HttpSession session = request.getSession();
            session.setAttribute("loggedInUser", user);
            request.getRequestDispatcher("/WEB-INF/JSP/MainToDoPage.jsp").forward(request, response);
        } else {
            request.setAttribute("errorMessage", "ユーザーIDまたはパスワードが正しくありません。");
            request.getRequestDispatcher("/WEB-INF/JSP/LoginPage.jsp").forward(request, response);
        }
    }
}
