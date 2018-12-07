package com.GAOSystem.Test;

import com.GAOSystem.Entity.UserEntity;
import com.GAOSystem.Impl.UserImpl;
import com.GAOSystem.Service.User;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

/**
 * @program: GAOSystem
 * @description: 测试的主体类
 * @author: DBC
 * @create: 2018-11-30 15:29
 **/
public class test {
    public static void main(String[] args){
        ApplicationContext applicationContext = new ClassPathXmlApplicationContext("applicationContext.xml");
        /*TestService testService = (TestService)applicationContext.getBean("testService");
        testService.hello();*/
        User user = (UserImpl)applicationContext.getBean("user");
        System.out.println(user.listUser("admin"));
    }
}
