package com.GAOSystem.Dao;

import com.GAOSystem.Entity.UserEntity;
import com.GAOSystem.Impl.UserImpl;
import com.GAOSystem.Service.User;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;

@WebServlet(name = "LoginServlet", urlPatterns = "/login")
public class LoginServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        ApplicationContext ac = new ClassPathXmlApplicationContext("applicationContext.xml");
        User user = (UserImpl)ac.getBean("user");
        response.setContentType("application/json;charset=utf-8");
        PrintWriter out =response.getWriter();
        response.setHeader("Access-Control-Allow-Origin", "*");
        String account = request.getParameter("account");
        String password = request.getParameter("password");
        String result = user.listPassword(account);
        if(result.equals("DIN")) out.append("{\"result\":\"1\"}");
        else{
            if(result.equals(password)){
                out.append("{\"result\":\"0\"}");
            }
            else out.append("{\"result\":\"2\"}");
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }
}
