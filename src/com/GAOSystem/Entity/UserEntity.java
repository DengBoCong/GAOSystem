package com.GAOSystem.Entity;

import javax.persistence.*;
import java.util.Objects;

/**
 * @program: GAOSystem
 * @description:
 * @author: DBC
 * @create: 2018-12-01 16:02
 **/
@Entity
@Table(name = "user", schema = "gaosystem", catalog = "")
public class UserEntity {
    private String account;
    private String name;
    private String password;

    @Id
    @Column(name = "account", nullable = false, length = 50)
    public String getAccount() {
        return account;
    }

    public void setAccount(String account) {
        this.account = account;
    }

    @Basic
    @Column(name = "name", nullable = true, length = 50)
    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    @Basic
    @Column(name = "password", nullable = false, length = 50)
    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        UserEntity that = (UserEntity) o;
        return Objects.equals(account, that.account) &&
                Objects.equals(name, that.name) &&
                Objects.equals(password, that.password);
    }

    @Override
    public int hashCode() {

        return Objects.hash(account, name, password);
    }
}
