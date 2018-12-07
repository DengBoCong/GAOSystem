package com.GAOSystem.Service;

import com.GAOSystem.Entity.ContentEntity;

public interface Content {
    public String list();
    public String listItem(String title);
    public boolean addItem(ContentEntity contentEntity);
    public boolean deleteItem(String title);
    public boolean deleteItemByOwner(String owner);
    public boolean deleteItemByFlag(String flag);
    public boolean updateItem(String title, int position, String value);
    public boolean updateItemContent(String title, String newTitle, String content);
    public ContentEntity getItem(String title);
    public String listByOwner(String owner);
    public String listByFlag(String flag);
    public String listByOwnerFlag(String ownerFlag);
}