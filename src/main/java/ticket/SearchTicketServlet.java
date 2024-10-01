package ticket;

import java.io.IOException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import bean.MainToDoBean;
import dao.SearchTicketDAO; // SearchTicketDAOをインポート

public class SearchTicketServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");
        response.setCharacterEncoding("UTF-8");


        // セッションからemailを取得
       // HttpSession session = request.getSession();
       // String email = (String) session.getAttribute("email");

        String email = request.getParameter("email");
        
        if (email == null || email.isEmpty()) {
            // emailがセッションにない場合、ログインページにリダイレクト
            response.sendRedirect("TopPageServlet");
            return;
        }

        // 検索条件を取得
        
        String criteria = request.getParameter("criteria");
        String searchText = request.getParameter("searchText");
        
        System.out.println("Servlet内の検索条件" + email + criteria + searchText);
        
        // DAOを使用して検索
        SearchTicketDAO searchTicketDAO = new SearchTicketDAO();
        try {
            // 検索結果を取得
        	System.out.println("検索トライ！");
            List<MainToDoBean> searchResults = searchTicketDAO.searchTickets(email, criteria, searchText);
            request.setAttribute("searchResults", searchResults);
            System.out.println("検索結果をあとりびゅーとにセットしましたよ");
            
            // JSPにフォワード
            RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/JSP/SearchResult.jsp");
            dispatcher.forward(request, response);
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
            // エラーハンドリングの追加（ユーザー向けのメッセージなど）
            request.setAttribute("errorMessage", "検索中にエラーが発生しました。");
            System.out.println("検索メソッドのえらーであとりびゅーとへのセットでエラーがおきましたよ");
            RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/JSP/error.jsp");
            dispatcher.forward(request, response);
        }
    }

}
