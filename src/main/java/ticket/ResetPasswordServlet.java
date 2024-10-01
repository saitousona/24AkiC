package ticket;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.ResetPasswordDAO;

public class ResetPasswordServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");
        response.setCharacterEncoding("UTF-8");

        String email = request.getParameter("email").trim();
        String secretWord = request.getParameter("secret_word").trim();
        String newPassword = request.getParameter("new_password");
        String confirmPassword = request.getParameter("confirm_password");

        ResetPasswordDAO resetPasswordDAO = new ResetPasswordDAO();

        // ユーザーの認証
        try {
            if (resetPasswordDAO.validateUser(email, secretWord)) {
                // 現在のパスワードと一世代前のパスワードを取得
                String currentPassword = resetPasswordDAO.getCurrentPassword(email);
                String oldPassword = resetPasswordDAO.getOldPassword(email);

                if (newPassword.equals(confirmPassword)) {
                    // 新しいパスワードが一世代前のパスワードと異なるか確認
                    if (!newPassword.equals(oldPassword)) {
                        // パスワードを更新
                        resetPasswordDAO.updatePassword(email, newPassword, currentPassword);
                        request.setAttribute("successMessage", "パスワードが変更されました。");
                        request.getRequestDispatcher("ResetPasswordResult").forward(request, response);
                    } else {
                        request.setAttribute("errorMessage", "新しいパスワードは一世代前のパスワードと同じです。");
                        request.getRequestDispatcher("ResetPasswordResult").forward(request, response);
                    }
                } else {
                    request.setAttribute("errorMessage", "新しいパスワードと確認用パスワードが一致しません。");
                    request.getRequestDispatcher("ResetPasswordResult").forward(request, response);
                }
            } else {
                request.setAttribute("errorMessage", "Emailまたは秘密の質問が間違っています。");
                request.getRequestDispatcher("ResetPasswordResult").forward(request, response);
            }
        } catch (ClassNotFoundException | ServletException | IOException e) {
            e.printStackTrace();
        }
    }
}
