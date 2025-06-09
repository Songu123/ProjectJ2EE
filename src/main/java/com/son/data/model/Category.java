package com.son.data.model;

public class Category {
    private int id;
    private String name;
    private String thumbnail;
    private String description;

    // Default constructor
    public Category() {
    }

    // Constructor for insert (without id, with description)
    public Category(String name, String thumbnail, String description) {
        this.name = name;
        this.thumbnail = thumbnail;
        this.description = description;
    }

    // Constructor for insert (without id, without description)
    public Category(String name, String thumbnail) {
        this.name = name;
        this.thumbnail = thumbnail;
    }

    // Constructor with id (with description)
    public Category(int id, String name, String thumbnail, String description) {
        this.id = id;
        this.name = name;
        this.thumbnail = thumbnail;
        this.description = description;
    }

    // Constructor with id (without description)
    public Category(int id, String name, String thumbnail) {
        this.id = id;
        this.name = name;
        this.thumbnail = thumbnail;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getThumbnail() {
        return thumbnail;
    }

    public void setThumbnail(String thumbnail) {
        this.thumbnail = thumbnail;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    @Override
    public String toString() {
        return "Category{" +
                "id=" + id +
                ", name='" + name + '\'' +
                ", thumbnail='" + thumbnail + '\'' +
                ", description='" + description + '\'' +
                '}';
    }
}