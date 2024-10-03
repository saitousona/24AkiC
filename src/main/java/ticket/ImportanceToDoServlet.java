package ticket;
	
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import bean.MainToDoBean;
import dao.MainToDoDAO;
		
	
	public class ImportanceToDoServlet extends HttpServlet {
	    private static final long serialVersionUID = 1L;
	
	    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	        MainToDoDAO dao = new MainToDoDAO();
	        HttpSession session = request.getSession();
	        String userEmail = (String) session.getAttribute("email"); // ユーザーのメールを取得
	        System.out.println(userEmail);
	        
	        try {
	            List<MainToDoBean> allTickets = dao.getTicketsByUserEmail(userEmail); // 全チケットを取得
	            
	            request.setAttribute("tickets", allTickets); // チケットリストをリクエストに設定
	            request.getRequestDispatcher("/WEB-INF/JSP/ImportanceToDoPage.jsp").forward(request, response); // JSPへフォワード
	        } catch (SQLException e) {
	            e.printStackTrace();
	            // エラーハンドリング
	        }
	    }
	    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	    	doGet(request, response);
	    }
	    
	}
	
	
