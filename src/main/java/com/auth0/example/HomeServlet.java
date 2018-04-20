package com.auth0.example;

import com.auth0.SessionUtils;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


import java.io.IOException;

@SuppressWarnings("serial")
@WebServlet(urlPatterns = {"/portal/home"})
public class HomeServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        final String accessToken = (String) SessionUtils.get(req, "accessToken");
        final String idToken = (String) SessionUtils.get(req, "idToken");
        String url = null;
        if (accessToken != null) {
            req.setAttribute("userId", accessToken);
            url="/WEB-INF/jsp/home.jsp?userId="+accessToken;
        } else if (idToken != null) {
            req.setAttribute("userId", idToken);
            url="/WEB-INF/jsp/home.jsp?userId="+idToken;
        }
        req.getRequestDispatcher(url).forward(req, res);
        
    }
}
