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

@WebServlet(name = "UpdataContentByTitleServlet", urlPatterns = "/updataContentByTitle")
public class UpdataContentByTitleServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("application/json;charset=utf-8");
        response.setHeader("Access-Control-Allow-Origin", "*");
        ApplicationContext ac = new ClassPathXmlApplicationContext("applicationContext.xml");
        Content content = (ContentImpl)ac.getBean("content");
        PrintWriter out = response.getWriter();
        String oldTitle = request.getParameter("oldTitle");
        String newTitle = request.getParameter("newTitle");
        String contentData = request.getParameter("content");
        System.out.println(":"+oldTitle+":");
        System.out.println(":"+newTitle+":");
        if(content.updateItemContent(oldTitle, newTitle, contentData)){
            out.append("{\"result\":\"0\"}");
        }else{
            out.append("{\"result\":\"1\"}");
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }
}
