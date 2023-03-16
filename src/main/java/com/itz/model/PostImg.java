package com.itz.model;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class PostImg {
    private int postImgId;
    private String picName;
    private int postId;

}
