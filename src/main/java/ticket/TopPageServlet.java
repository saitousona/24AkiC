package ticket;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class TopPageServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // エラーメッセージをセッションに保存
        String errorMessage = (String) request.getAttribute("errorMessage");
        if (errorMessage != null) {
            request.getSession().setAttribute("errorMessage", errorMessage);
        }

        // LoginPage.jsp へのリダイレクト
        response.sendRedirect(request.getContextPath() + "/LoginPage");
    }
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }
}
