package filter;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;

public class SanitizeFilter implements Filter {

    public void init(FilterConfig filterConfig) throws ServletException {
    }

    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        
        // サニタイズされたリクエストでラップして次に渡す
        HttpServletRequest httpRequest = (HttpServletRequest) request;
        SanitizeRequestWrapper sanitizedRequest = new SanitizeRequestWrapper(httpRequest);
        chain.doFilter(sanitizedRequest, response);
    }

    public void destroy() {
    }
}
