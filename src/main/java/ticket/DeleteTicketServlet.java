package ticket;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.TicketOperationDAO;

public class DeleteTicketServlet extends HttpServlet {
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String ticketId = request.getParameter("ticketId");

        // DAOを呼び出して削除処理を実行
        TicketOperationDAO ticketDAO = new TicketOperationDAO();
        try {
			ticketDAO.deleteTicket(ticketId);
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}
        
        // セッションからcurrentPageを取得
        HttpSession session = request.getSession();
        String currentPage = (String) session.getAttribute("currentPage"); // スペル修正

        // currentPageが存在しない場合のフォールバック処理
        if (currentPage == null || currentPage.isEmpty()) {
            currentPage = "MainToDoPage";  // 適切なデフォルトページ
        }

        // チケット一覧ページにリダイレクト
        response.sendRedirect(currentPage);
    }
}
