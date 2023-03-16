package com.itz.model;

public class FollowBar {
    private int exp;
    private int level;
    private int deleted;

    @Override
    public String toString() {
        return "FollowBar{" +
                "exp=" + exp +
                ", level=" + level +
                ", deleted=" + deleted +
                '}';
    }

    public int getExp() {
        return exp;
    }

    public void setExp(int exp) {
        this.exp = exp;
    }

    public int getLevel() {
        return level;
    }

    public void setLevel(int level) {
        this.level = level;
    }

    public int getDeleted() {
        return deleted;
    }

    public void setDeleted(int deleted) {
        this.deleted = deleted;
    }
}
