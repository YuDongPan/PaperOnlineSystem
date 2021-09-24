package com.pyd.paperonlinesystem.filter;

import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import java.io.IOException;

/**
 * @ClassName: EncodingFilter
 * @Description: TODO
 * @author: Ethan_Hunt
 * @date: 2021/9/21  20:52
 */
@WebFilter("/*")
public class EncodingFilter implements Filter {
    private ServletRequest request;
    private ServletResponse response;
    private FilterChain chain;

    @Override
    public void init(FilterConfig arg0) throws ServletException {
        // TODO 自动生成的方法存根

    }
    @Override
    public void destroy() {
        // TODO 自动生成的方法存根

    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        this.request = request;
        this.response = response;
        this.chain = chain;
        //设置字符编码
        request.setCharacterEncoding("UTF-8");
        //放行
        chain.doFilter(request, response);
    }
}
