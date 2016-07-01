package com.jftechnology.ticketing.fx.customer.ember;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;

/**
 * Servlet Filter implementation class Application
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

        System.out.println("Application.doFilter() "
                + ((HttpServletRequest) request).getRequestURI());

        dispatcher.forward(request, response);
    }

    /**
     * @see Filter#init(FilterConfig)
     */
    @Override
    public void init(FilterConfig config) throws ServletException {

        // no-op
        index = config.getInitParameter("index");
        System.out.println("Filter :: Application :: init :: " + index);
        System.out.println("Filter :: Application :: init :: "
                + config.getServletContext().getContextPath());
    }

    /**
     * @see Filter#destroy()
     */
    @Override
    public void destroy() {

        // no-op
    }
}
