package ticket;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.CreateUserDAO;


public class CreateUserServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");
        response.setCharacterEncoding("UTF-8");

        String email = request.getParameter("email").trim();
        String userName = request.getParameter("user_name").trim();
        String password = request.getParameter("password");
        String secretWord = request.getParameter("secret_word").trim();

        // ユーザーの登録処理
        CreateUserDAO createUserDAO = new CreateUserDAO();

        try {
        	

            boolean isUserCreated = createUserDAO.createUser(email, userName, password, secretWord);
            if (isUserCreated) {
                request.setAttribute("successMessage", "ユーザーが正常に作成されました。");
                request.getRequestDispatcher("/WEB-INF/JSP/CreateUserSuccess.jsp").forward(request, response);
            } else {
                request.setAttribute("errorMessage", "ユーザーの作成に失敗しました。すでに同じEmailが存在している可能性があります。");
                request.getRequestDispatcher("/WEB-INF/JSP/CreateUserError.jsp").forward(request, response);
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "システムエラーが発生しました。");
            request.getRequestDispatcher("/WEB-INF/JSP/CreateUserError.jsp").forward(request, response);
        }
    }
}
