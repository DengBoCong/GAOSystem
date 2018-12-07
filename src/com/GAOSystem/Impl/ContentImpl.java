package com.GAOSystem.Impl;

import com.GAOSystem.Entity.ContentEntity;
import com.GAOSystem.Service.Content;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;

import java.util.Iterator;
import java.util.List;

/**
 * @program: GAOSystem
 * @description: 分支的接口类
 * @author: DBC
 * @create: 2018-12-04 19:07
 **/
public class ContentImpl implements Content {
    @Qualifier("sessionFactory")
    @Autowired
    private SessionFactory sessionFactory;

    @Override
    public String list() {
        Session session = sessionFactory.openSession();
        String listJson = "";
        int count = 0;
        List userList =session.createQuery("FROM ContentEntity ").list();
        session.close();
        if(userList.size() == 0) return "DIN";
        for(Iterator iterator = userList.iterator(); iterator.hasNext();){
            String temp = "";
            ContentEntity contentEntity = (ContentEntity) iterator.next();
            temp = temp + "{\"title\":\"" + contentEntity.getTitle() + "\"";
            temp = temp + ",\"flag\":\"" + contentEntity.getFlag() + "\"";
            temp = temp + ",\"content\":\"" + contentEntity.getContent() + "\"";
            temp = temp + ",\"owner\":\"" + contentEntity.getOwner() + "\"";
            temp = temp + ",\"sub\":\"" + contentEntity.getSub() + "\"}";
            if(count == 0) temp = temp + "]";
            else temp = temp + ",";
            count++;
            listJson = temp + listJson;
        }
        listJson = "[" + listJson;
        return listJson;
    }

    @Override
    public String listItem(String title) {
        Session session = sessionFactory.openSession();
        ContentEntity contentEntity = null;
        contentEntity = (ContentEntity)session.get(ContentEntity.class, title);
        session.close();
        if(contentEntity == null) return "DIN";
        String temp = "";
        temp = temp + "{\"title\":\"" + contentEntity.getTitle() + "\"";
        temp = temp + ",\"flag\":\"" + contentEntity.getFlag() + "\"";
        temp = temp + ",\"content\":\"" + contentEntity.getContent() + "\"";
        temp = temp + ",\"owner\":\"" + contentEntity.getOwner() + "\"";
        temp = temp + ",\"sub\":\"" + contentEntity.getSub() + "\"}";
        return temp;
    }

    @Override
    public boolean addItem(ContentEntity contentEntity) {
        Session session = sessionFactory.openSession();
        Transaction transaction = session.beginTransaction();
        ContentEntity contentEntity1 = null;
        contentEntity1 = (ContentEntity)session.get(ContentEntity.class, contentEntity.getTitle());
        if(contentEntity1 != null) return false;
        session.save(contentEntity);
        transaction.commit();
        session.close();
        return true;
    }

    @Override
    public boolean deleteItem(String title) {
        Session session = sessionFactory.openSession();
        Transaction transaction = session.beginTransaction();
        ContentEntity contentEntity = null;
        contentEntity = (ContentEntity)session.get(ContentEntity.class, title);
        if(contentEntity == null) return false;
        session.delete(contentEntity);
        transaction.commit();
        session.close();
        return true;
    }

    @Override
    public boolean deleteItemByOwner(String owner) {
        Session session = sessionFactory.openSession();
        Transaction transaction = session.beginTransaction();
        List contentList =session.createQuery("FROM ContentEntity contentEntity where contentEntity.owner ='" + owner + "'")
                .list();
        if(contentList.size() == 0) return true;
        for(Iterator iterator = contentList.iterator(); iterator.hasNext();){
            ContentEntity contentEntity = (ContentEntity) iterator.next();
            System.out.println(contentEntity.getOwner());
            System.out.println(contentEntity.getTitle());
            session.delete(contentEntity);
        }
        transaction.commit();
        session.close();
        return true;
    }

    @Override
    public boolean deleteItemByFlag(String flag) {
        Session session = sessionFactory.openSession();
        Transaction transaction = session.beginTransaction();
        List contentList =session.createQuery("FROM ContentEntity contentEntity where contentEntity.flag ='" + flag + "'")
                .list();
        if(contentList.size() == 0) return true;
        for(Iterator iterator = contentList.iterator(); iterator.hasNext();){
            ContentEntity contentEntity = (ContentEntity) iterator.next();
            session.delete(contentEntity);
        }
        transaction.commit();
        session.close();
        return true;
    }

    @Override
    public boolean updateItem(String title, int position, String value) {
        Session session = sessionFactory.openSession();
        Transaction transaction = session.beginTransaction();
        ContentEntity contentEntity = null;
        contentEntity = (ContentEntity)session.get(ContentEntity.class, title);
        if(contentEntity == null) return false;
        switch (position){
            case 1:contentEntity.setTitle(value);break;
            case 2:contentEntity.setContent(value);break;
            case 3:contentEntity.setFlag(value);break;
            case 4:contentEntity.setSub(Integer.parseInt(value));break;
            case 5:contentEntity.setOwner(value);break;
        }
        session.update(contentEntity);
        transaction.commit();
        session.close();
        return true;
    }

    @Override
    public boolean updateItemContent(String title, String newTitle, String content) {
        Session session = sessionFactory.openSession();
        Transaction transaction = session.beginTransaction();
        System.out.println(":"+title+":");
        System.out.println(":"+newTitle+":");
        ContentEntity contentEntity = null;
        contentEntity = (ContentEntity)session.get(ContentEntity.class, title);
        if(contentEntity == null) return false;
        System.out.println("1");

        if(title.equals(newTitle)){
            System.out.println("2");
            contentEntity.setContent(content);
            session.update(contentEntity);
        }else{
            System.out.println("3");
            ContentEntity contentEntity1 = null;
            contentEntity1 = (ContentEntity)session.get(ContentEntity.class, newTitle);
            if(contentEntity1 != null) return false;

            ContentEntity contentEntity2 = new ContentEntity();
            contentEntity2.setTitle(newTitle);
            contentEntity2.setContent(content);
            contentEntity2.setOwner(contentEntity.getOwner());
            contentEntity2.setSub(contentEntity.getSub());
            contentEntity2.setFlag(contentEntity.getFlag());
            session.delete(contentEntity);
            session.save(contentEntity2);
        }
        System.out.println("4");
        transaction.commit();
        session.close();
        return true;
    }

    @Override
    public ContentEntity getItem(String title) {
        Session session = sessionFactory.openSession();
        ContentEntity contentEntity = null;
        contentEntity = (ContentEntity)session.get(ContentEntity.class, title);
        session.close();
        return contentEntity;
    }

    @Override
    public String listByOwner(String owner) {
        Session session = sessionFactory.openSession();
        String listJson = "";
        int count = 0;
        System.out.println(owner);
        List contentList =session.createQuery("FROM ContentEntity contentEntity where contentEntity.owner ='" + owner + "'")
                .list();
        session.close();
        if(contentList.size() == 0) return "DIN";
        for(Iterator iterator = contentList.iterator(); iterator.hasNext();){
            String temp = "";
            ContentEntity contentEntity = (ContentEntity) iterator.next();
            temp = temp + "{\"title\":\"" + contentEntity.getTitle() + "\"";
            temp = temp + ",\"flag\":\"" + contentEntity.getFlag() + "\"";
            temp = temp + ",\"content\":\"" + contentEntity.getContent() + "\"";
            temp = temp + ",\"owner\":\"" + contentEntity.getOwner() + "\"";
            temp = temp + ",\"sub\":\"" + contentEntity.getSub() + "\"}";
            if(count == 0) temp = temp + "]";
            else temp = temp + ",";
            count++;
            listJson = temp + listJson;
        }
        listJson = "[" + listJson;
        return listJson;
    }

    @Override
    public String listByFlag(String flag) {
        Session session = sessionFactory.openSession();
        String listJson = "";
        int count = 0;
        System.out.println(flag);
        List contentList =session.createQuery("FROM ContentEntity contentEntity where contentEntity.flag ='" + flag + "'")
                .list();
        session.close();
        if(contentList.size() == 0) return "DIN";
        for(Iterator iterator = contentList.iterator(); iterator.hasNext();){
            String temp = "";
            ContentEntity contentEntity = (ContentEntity) iterator.next();
            temp = temp + "{\"title\":\"" + contentEntity.getTitle() + "\"";
            temp = temp + ",\"flag\":\"" + contentEntity.getFlag() + "\"";
            temp = temp + ",\"content\":\"" + contentEntity.getContent() + "\"";
            temp = temp + ",\"owner\":\"" + contentEntity.getOwner() + "\"";
            temp = temp + ",\"sub\":\"" + contentEntity.getSub() + "\"}";
            if(count == 0) temp = temp + "]";
            else temp = temp + ",";
            count++;
            listJson = temp + listJson;
        }
        listJson = "[" + listJson;
        return listJson;
    }

    @Override
    public String listByOwnerFlag(String ownerFlag) {
        Session session = sessionFactory.openSession();
        String listJson = "";
        int count = 0;
        System.out.println(ownerFlag);
        List contentList =session.createQuery("FROM ContentEntity contentEntity where contentEntity.flag =" + ownerFlag)
                .list();
        session.close();
        if(contentList.size() == 0) return "DIN";
        for(Iterator iterator = contentList.iterator(); iterator.hasNext();){
            String temp = "";
            ContentEntity contentEntity = (ContentEntity) iterator.next();
            temp = temp + "{\"title\":\"" + contentEntity.getTitle() + "\"";
            temp = temp + ",\"flag\":\"" + contentEntity.getFlag() + "\"";
            temp = temp + ",\"content\":\"" + contentEntity.getContent() + "\"";
            temp = temp + ",\"owner\":\"" + contentEntity.getOwner() + "\"";
            temp = temp + ",\"sub\":\"" + contentEntity.getSub() + "\"}";
            if(count == 0) temp = temp + "]";
            else temp = temp + ",";
            count++;
            listJson = temp + listJson;
        }
        listJson = "[" + listJson;
        return listJson;
    }

    public void setSessionFactory(SessionFactory sessionFactory) {
        this.sessionFactory = sessionFactory;
    }
}
