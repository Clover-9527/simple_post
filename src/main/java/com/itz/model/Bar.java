package com.itz.model;

public class Bar {
    private int barId;
    private String barName;
    private String picName;
    private String userId;
    private FollowBar followBar;

    @Override
    public String toString() {
        return "Bar{" +
                "barId=" + barId +
                ", barName='" + barName + '\'' +
                ", picName='" + picName + '\'' +
                ", userId='" + userId + '\'' +
                ", followBar=" + followBar +
                '}';
    }

    public int getBarId() {
        return barId;
    }

    public void setBarId(int barId) {
        this.barId = barId;
    }

    public String getBarName() {
        return barName;
    }

    public void setBarName(String barName) {
        this.barName = barName;
    }

    public String getPicName() {
        return picName;
    }

    public void setPicName(String picName) {
        this.picName = picName;
    }

    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }

    public FollowBar getFollowBar() {
        return followBar;
    }

    public void setFollowBar(FollowBar followBar) {
        this.followBar = followBar;
    }
}
