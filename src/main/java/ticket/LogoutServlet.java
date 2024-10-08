package ticket;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class LogoutServlet extends HttpServlet {


    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // セッションを取得
        HttpSession session = request.getSession(false); // 既存のセッションがない場合は新規作成しない
        if (session != null) {
            session.invalidate(); // セッションを無効化
        }
        // ログインページにリダイレクト
        response.sendRedirect("TopPageServlet");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}
