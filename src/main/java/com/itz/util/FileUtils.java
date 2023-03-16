package com.itz.util;

import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

public class FileUtils {
    private static String dirPath = "C:/upload/images/";

    // 单文件上传
    public static String fileUploadSingle(MultipartFile file){

        if(!file.isEmpty()){
            // 获取上传文件的原始名称
            String originalFilename = file.getOriginalFilename();
            // 获取文件后缀
            String suffix = originalFilename.substring(originalFilename.lastIndexOf("."));

            // 设置上传文件的保存地址目录
            //    String dirPath = request.getServletContext().getRealPath("/upload/");
     //       String dirPath = "C:/upload/images/"; // 上传到其它目录，文件不会随tomcat重启消失
            File filePath = new File(dirPath);
            // 如果保存文件的地址不存在，就先创建目录
            if (!filePath.exists()) {
                filePath.mkdirs();
            }
            // 使用UUID重新命名上传的文件名称(uuid_原始文件名称)
            String newFilename = UUID.randomUUID() +suffix;
            try {
                // 使用MultipartFile接口的方法完成文件上传到指定位置
                file.transferTo(new File(dirPath + newFilename));
                return newFilename;
            } catch (Exception e) {
                e.printStackTrace();
            }

        }
        return null;
    }

    // 多文件上传
    public static List<String> fileUploadBatch(List<MultipartFile> fileList){
        List<String> list = new ArrayList<>();
        // 判断所上传文件是否存在
        if (!fileList.isEmpty() && fileList.size() > 0) {
            //循环输出上传的文件
            for (MultipartFile file : fileList) {
                if(file.getSize()>0){
                    // 获取上传文件的原始名称
                    String originalFilename = file.getOriginalFilename();
                    // 获取文件后缀
                    String suffix = originalFilename.substring(originalFilename.lastIndexOf("."));
                    // 设置上传文件的保存地址目录
                    //    String dirPath = request.getServletContext().getRealPath("/upload/");
                    //    String dirPath = "C:/upload/images/; // 上传到其它目录，文件不会随tomcat重启消失
                    File filePath = new File(dirPath);
                    // 如果保存文件的地址不存在，就先创建目录
                    if (!filePath.exists()) {
                        filePath.mkdirs();
                    }
                    // 使用UUID重新命名上传的文件名称(uuid_原始文件名称)
                    String newFilename = UUID.randomUUID() +suffix;
                    try {
                        // 使用MultipartFile接口的方法完成文件上传到指定位置
                        file.transferTo(new File(dirPath + newFilename));
                        list.add(newFilename);
                    } catch (Exception e) {
                        e.printStackTrace();
                    }
                }

            }
        }
        return list;
    }
}
