package com.GAOSystem.Dao;

import com.GAOSystem.Entity.ContentEntity;
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

@WebServlet(name = "AddContentServlet", urlPatterns = "/add")
public class AddContentServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("application/json;charset=utf-8");
        response.setHeader("Access-Control-Allow-Origin", "*");
        ApplicationContext ac = new ClassPathXmlApplicationContext("applicationContext.xml");
        Content content = (ContentImpl)ac.getBean("content");
        PrintWriter out = response.getWriter();
        String title = request.getParameter("title");
        String flag = request.getParameter("flag");
        String text = request.getParameter("content");
        String owner = request.getParameter("owner");
        int sub = Integer.parseInt(request.getParameter("sub"));
        ContentEntity contentEntity = new ContentEntity();
        contentEntity.setTitle(title);
        contentEntity.setContent(text);
        contentEntity.setFlag(flag);
        contentEntity.setSub(sub);
        contentEntity.setOwner(owner);
        if(content.addItem(contentEntity)){
            out.append("{\"result\":\"0\"}");
        }else{
            out.append("{\"result\":\"1\"}");
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }
}
