package filter;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class LoginFilter implements Filter {
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;
        HttpSession session = httpRequest.getSession(false);
        
        System.out.println("フィルタによるログインチェック開始");
        
        // ログインしていない場合はログインページへリダイレクト
        if (session == null || session.getAttribute("loggedInUser") == null) {
            System.out.println("ログインされていません。ログインページへリダイレクトします。");
            httpResponse.sendRedirect(httpRequest.getContextPath() + "/LoginPage");
        } else {
            // ログインしていれば通常の処理を続行
            System.out.println("ログイン済み。次のフィルタまたはサーブレットに進みます。");
            chain.doFilter(request, response);
        }
    }

    public void init(FilterConfig fConfig) throws ServletException {
        System.out.println("LoginFilter 初期化");
    }

    public void destroy() {
        System.out.println("LoginFilter 破棄");
    }
}
