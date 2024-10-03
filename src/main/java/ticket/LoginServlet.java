package ticket;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import bean.UsersBean;
import dao.LoginDAO;

public class LoginServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    	
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");
        response.setCharacterEncoding("UTF-8");


        // リクエストからemailとpasswordを取得
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        // 認証処理
        LoginDAO loginDAO = new LoginDAO();
        UsersBean authenticatedUser = null;
        
        try {
            authenticatedUser = loginDAO.authenticate(email, password);
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "システムエラーが発生しました。管理者に連絡してください。");
            RequestDispatcher dispatcher = request.getRequestDispatcher("login.jsp");
            dispatcher.forward(request, response);
            return;
        }

        if (authenticatedUser != null) {
            // 認証成功時にセッションにemailとuser_nameを保存
            HttpSession session = request.getSession();
            session.setAttribute("email", authenticatedUser.getEmail());
            session.setAttribute("userName", authenticatedUser.getUserName());

            // MainToDoServletにリダイレクト
            response.sendRedirect("MainToDoServlet");
        } else {
            // 認証失敗時にエラーメッセージをリクエストスコープにセット
            request.setAttribute("errorMessage", "メールアドレスまたはパスワードが間違っています");

            // ログインページにフォワード
            RequestDispatcher dispatcher = request.getRequestDispatcher("TopPageServlet");
            dispatcher.forward(request, response);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // 通常はPOSTメソッドを使用するが、GETで来た場合もlogin.jspにフォワード
        RequestDispatcher dispatcher = request.getRequestDispatcher("TopPageServlet");
        dispatcher.forward(request, response);
    }
}
