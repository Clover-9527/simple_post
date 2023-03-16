package com.itz.controller;
/**
import com.massz.model.ApiResult;
import com.massz.model.Users;
import com.massz.service.UsersService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpSession;
import java.io.File;
import java.util.UUID;

@RequestMapping("file")
@Controller
public class FileController {
    @Autowired
    private UsersService usersService;

    // 头像上传（单文件）
    @PostMapping("avatarUpload")
    public ApiResult avatarUpload(@RequestParam("filename") MultipartFile file, Users usersVo, HttpSession session) {
        ApiResult apiResult = new ApiResult();
        if (file != null) {
            // 获取上传文件的原始名称
            String originalFilename = file.getOriginalFilename();
            // 获取文件后缀
            String suffix = originalFilename.substring(originalFilename.lastIndexOf("."));

            // 设置上传文件的保存地址目录
            //    String dirPath = request.getServletContext().getRealPath("/upload/");
            String dirPath = "E:/upload/images/"; // 上传到其它目录，文件不会随tomcat重启消失
            File filePath = new File(dirPath);
            // 如果保存文件的地址不存在，就先创建目录
            if (!filePath.exists()) {
                filePath.mkdirs();
            }
            // 使用UUID重新命名上传的文件名称(uuid_原始文件名称)
            String newFilename = UUID.randomUUID() + suffix;
            try {
                // 使用MultipartFile接口的方法完成文件上传到指定位置
                file.transferTo(new File(dirPath + newFilename));
                System.out.println(newFilename);
            } catch (Exception e) {
                e.printStackTrace();
            }


            // 更新users表中的头像字段，改为文件名
            Users users = (Users) session.getAttribute("userSession");
            users.setAvatar(newFilename);
            int result = usersService.updateUser(users);
            if (result > 0) {
                // 更新session
                session.setAttribute("userSession", users);
                apiResult.setCode(200);
            }else{
                apiResult.setCode(400);
                apiResult.setMessage("上传失败!");
            }
        }else{
            apiResult.setCode(400);
            apiResult.setMessage("请选择一张图片!");
        }
        return apiResult;
    }

}
 **/