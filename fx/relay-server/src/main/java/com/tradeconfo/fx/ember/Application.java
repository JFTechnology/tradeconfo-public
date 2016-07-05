package com.tradeconfo.fx.ember;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;

/**
 * Servlet Filter implementation class Application produces ember application
 * home page for all request to index
 */
public class Application implements Filter {

    private String index;

    /**
     * @see Filter#doFilter(ServletRequest, ServletResponse, FilterChain)
     */
    @Override
    public void doFilter(ServletRequest request, ServletResponse response,
            FilterChain chain) throws IOException, ServletException {

        RequestDispatcher dispatcher = request.getRequestDispatcher(index);

        dispatcher.forward(request, response);
    }

    /**
     * @see Filter#init(FilterConfig)
     */
    @Override
    public void init(FilterConfig config) throws ServletException {

        index = config.getInitParameter("index");
    }

    /**
     * @see Filter#destroy()
     */
    @Override
    public void destroy() {

        // no-op
    }
}
