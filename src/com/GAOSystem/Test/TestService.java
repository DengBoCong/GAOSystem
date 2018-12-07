package com.GAOSystem.Test;

/**
 * @program: GAOSystem
 * @description: 测试Spring类
 * @author: DBC
 * @create: 2018-11-30 15:23
 **/
public class TestService {
    private String name;

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public void hello(){
        System.out.println("hello" + getName());
    }
}
