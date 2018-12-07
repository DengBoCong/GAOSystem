package com.GAOSystem.Dao;

import com.GAOSystem.Impl.ContentImpl;
import com.GAOSystem.Service.Content;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;

@WebServlet(name = "ListContentByTitleServlet", urlPatterns = "/listContentByTitle")
public class ListContentByTitleServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("application/json;charset=utf-8");
        response.setHeader("Access-Control-Allow-Origin", "*");
        ApplicationContext ac = new ClassPathXmlApplicationContext("applicationContext.xml");
        Content content = (ContentImpl)ac.getBean("content");
        PrintWriter out = response.getWriter();
        String title = request.getParameter("title");
        System.out.println(title);
        String listJson = content.listItem(title);
        if(listJson == "DIN"){
            out.append("{\"result\":\"1\"}");
        }else{
            out.append(listJson);
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }
}
