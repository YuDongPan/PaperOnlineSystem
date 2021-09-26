package com.pyd.paperonlinesystem.filter;

import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

/**
 * @ClassName: AdminFilter
 * @Description: TODO
 * @author: Ethan_Hunt
 * @date: 2021/9/26  11:11
 */
@WebFilter("/paper/*")
public class LoginFilter implements Filter{
    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        // TODO Auto-generated method stub

    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response,
                         FilterChain chain) throws IOException, ServletException {
        HttpServletRequest httpRequest = (HttpServletRequest)request;
        HttpServletResponse httpResponse = (HttpServletResponse)response;
        HttpSession session = httpRequest.getSession();
        String url = httpRequest.getRequestURI();
        String[] str = url.split("/");
        String context = str[str.length - 1];
        int has_Admin = context.indexOf("admin");
        String identity = (String)session.getAttribute("loginUsername");
        if(identity != null){
           if(identity.equals("admin")) {
                //通行
                chain.doFilter(request, response);
            }
            else{
                if(has_Admin != -1){
                    httpResponse.sendRedirect("../user/unauthorized_admin.jsp");
                }
                //通行
                else {
                    chain.doFilter(request, response);
                }
            }
        } else {
            httpResponse.sendRedirect("../user/login_first.jsp");
        }
    }

    @Override
    public void destroy() {
        // TODO Auto-generated method stub

    }


}
