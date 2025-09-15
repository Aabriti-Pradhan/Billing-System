package com.SimpleProject.SpringCrud.Config;


import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;

@Component
public class SessionInterceptor implements HandlerInterceptor {

    @Override
    public boolean preHandle(HttpServletRequest request,
                             HttpServletResponse response,
                             Object handler) throws Exception {

        HttpSession session = request.getSession(false); // get session if exists
        String uri = request.getRequestURI();

        // Allow login and signup pages without session
        if (uri.startsWith("/login") || uri.startsWith("/signup") || uri.startsWith("/css") || uri.startsWith("/js")) {
            return true;
        }

        // If session exists and user logged in
        if (session != null && session.getAttribute("loggedInUser") != null) {
            return true; // allow
        }

        // Not logged in, redirect to login page
        response.sendRedirect(request.getContextPath() + "/login");
        return false;
    }
}
