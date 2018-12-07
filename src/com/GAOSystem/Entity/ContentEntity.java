package com.GAOSystem.Entity;

import javax.persistence.*;
import java.util.Objects;

/**
 * @program: GAOSystem
 * @description:
 * @author: DBC
 * @create: 2018-12-05 17:20
 **/
@Entity
@Table(name = "content", schema = "gaosystem", catalog = "")
public class ContentEntity {
    private String title;
    private String flag;
    private String content;
    private Integer sub;
    private String owner;

    @Id
    @Column(name = "title", nullable = false, length = 50)
    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    @Basic
    @Column(name = "flag", nullable = true, length = 50)
    public String getFlag() {
        return flag;
    }

    public void setFlag(String flag) {
        this.flag = flag;
    }

    @Basic
    @Column(name = "content", nullable = true, length = -1)
    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    @Basic
    @Column(name = "sub", nullable = true)
    public Integer getSub() {
        return sub;
    }

    public void setSub(Integer sub) {
        this.sub = sub;
    }

    @Basic
    @Column(name = "owner", nullable = true, length = 50)
    public String getOwner() {
        return owner;
    }

    public void setOwner(String owner) {
        this.owner = owner;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        ContentEntity that = (ContentEntity) o;
        return Objects.equals(title, that.title) &&
                Objects.equals(flag, that.flag) &&
                Objects.equals(content, that.content) &&
                Objects.equals(sub, that.sub) &&
                Objects.equals(owner, that.owner);
    }

    @Override
    public int hashCode() {

        return Objects.hash(title, flag, content, sub, owner);
    }
}
