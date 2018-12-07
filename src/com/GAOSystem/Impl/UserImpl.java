package com.GAOSystem.Impl;

import com.GAOSystem.Entity.UserEntity;
import com.GAOSystem.Service.User;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.transaction.annotation.Transactional;

import java.util.Iterator;
import java.util.List;

/**
 * @program: GAOSystem
 * @description: 用户类的接口实现类
 * @author: DBC
 * @create: 2018-12-01 16:06
 **/
public class UserImpl implements User {
    @Qualifier("sessionFactory")
    @Autowired
    private SessionFactory sessionFactory;

    @Override
    public String list() {
        Session session = sessionFactory.openSession();
        String listJson = "";
        int count = 0;
        List userList =session.createQuery("FROM UserEntity ").list();
        session.close();
        if(userList.size() == 0) return "DIN";
        for(Iterator iterator = userList.iterator(); iterator.hasNext();){
            String temp = "";
            UserEntity userEntity = (UserEntity)iterator.next();
            temp = temp + "{\"account\":\"" + userEntity.getAccount() + "\"";
            temp = temp + ",\"name\":\"" + userEntity.getName() + "\"";
            temp = temp + ",\"password\":\"" + userEntity.getPassword() + "\"}";
            if(count == 0) temp = temp + "]";
            else temp = temp + ",";
            count++;
            listJson = temp + listJson;
        }
        listJson = "[" + listJson;
        return listJson;
    }

    @Override
    public String listUser(String account) {
        Session session = sessionFactory.openSession();
        UserEntity userEntity = null;
        userEntity = (UserEntity)session.get(UserEntity.class, account);
        session.close();
        if(userEntity == null) return "DIN";
        String temp = "";
        temp = temp + "{\"account\":\"" + userEntity.getAccount() + "\"";
        temp = temp + ",\"name\":\"" + userEntity.getName() + "\"";
        temp = temp + ",\"password\":\"" + userEntity.getPassword() + "\"}";
        return temp;
    }

    @Override
    public String listPassword(String account) {
        Session session = sessionFactory.openSession();
        UserEntity userEntity = null;
        userEntity = (UserEntity)session.get(UserEntity.class, account);
        session.close();
        if(userEntity == null) return "DIN";
        else return userEntity.getPassword();
    }

    public void setSessionFactory(SessionFactory sessionFactory){
        this.sessionFactory = sessionFactory;
    }
}
