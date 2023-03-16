package com.itz.controller;

import com.itz.util.FileUtils;
import com.itz.model.ApiResult;
import com.itz.model.Users;
import com.itz.service.UsersService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpSession;
import java.util.List;
import java.util.Map;


@Controller
@RequestMapping("/user")
public class UsersController {

    @Autowired
    private UsersService usersService;

    // 跳转到登录页面
    @RequestMapping("/toLogin")
    public String toLogin(){
        return "login";
    }
    // 跳转到我的页面
    @RequestMapping("/toMy")
    public String toSuccess(){
        return "user/my";
    }
    // 跳转到注册页面
    @RequestMapping("toRegister")
    public String toRegister(){
        return "register";
    }
    // 去设置页面
    @RequestMapping("toSet")
    public String toSet(){
        return "user/set";
    }
    // 去修改信息页面
    @RequestMapping("toUserInfo")
    public String toUserInfo(){
        return "user/userinfo";
    }
    // 跳转到关注列表页面
    @GetMapping("/toFollowUser")
    public String toFollowUser(){
        return "user/followuser";
    }
    // 跳转到粉丝列表页面
    @GetMapping("/toFans")
    public String toFans(){
        return "user/myfans";
    }
    //去关注的吧列表页面
    @GetMapping("/toFollowBar")
    public String toFollowBar(){
        return "user/myfollowbar";
    }
    //去用户信息页面
    @GetMapping("/toUserHome/{userId}")
    public String toUserHome(@PathVariable String userId,HttpSession session){
        session.setAttribute("userId",userId);
        return "user/userhome";
    }
    //去我的收藏页面
    @GetMapping("/toMyCollection")
    public String toMyCollection(){
        return "user/mycollection";
    }
    //去浏览历史页面
    @GetMapping("/toMyHistory")
    public String toMyHistory(){
        return "user/history";
    }
// ============================================================================
    // 登录
    @PostMapping("/login")
    @ResponseBody
    public ApiResult login(Users usersVo, HttpSession session){
        Users users = usersService.findUsersByUserName(usersVo.getUserName());
        ApiResult apiResult = new ApiResult();
        if(users == null){
            apiResult.setCode(400);
            apiResult.setMessage("用户名不存在！");
        }else{
            if(users.getPassword().equals(usersVo.getPassword())){
                apiResult.setCode(200);
                session.setAttribute("userSession",users);
                apiResult.setMessage("登录成功");
            }else{
                apiResult.setCode(400);
                apiResult.setMessage("密码错误");
            }
        }
        return apiResult;
    }


    // 用户注册
    @PostMapping("register")
    @ResponseBody
    public ApiResult register(Users usersVo){
        int result = usersService.insertUsers(usersVo);
        ApiResult apiResult = new ApiResult();
        if(result>0){
            apiResult.setCode(200);
        }else{
            apiResult.setCode(400);
            apiResult.setMessage("注册失败");
        }
        return apiResult;
    }

    // 判断用户是否已存在
    @GetMapping("userNameExist")
    @ResponseBody
    public ApiResult userNameExist(String userName){
        Users users = usersService.findUsersByUserName(userName);
        ApiResult apiResult = new ApiResult();
        if(users == null){
            apiResult.setCode(200);
            apiResult.setData(0);
        }else{
            apiResult.setCode(200);
            apiResult.setData(1);
        }
        return apiResult;
    }

    // 退出
    @RequestMapping("logout")
    public String logout(HttpSession session){
        // 销毁回话
        session.invalidate();
        // 重定向到登录页面
        return "redirect:/user/toLogin";
    }

    @GetMapping("/selectCount")
    @ResponseBody
    public Map selectCount(Integer userId,HttpSession session){
        Users user = (Users) session.getAttribute("userSession");
        Map countMap = usersService.selectCount(user.getUserId());
        session.setAttribute("countMap",countMap);
        return countMap;
    }

    // 修改用户信息
    @PostMapping("/updateUser")
    @ResponseBody
    public ApiResult updateUser(@RequestParam("filename") MultipartFile file,Users usersVo,HttpSession session) {
        ApiResult apiResult = new ApiResult();
        String fileName = FileUtils.fileUploadSingle(file);

            String nickName = usersVo.getNickName();
            String gender = usersVo.getGender();
            String signature = usersVo.getSignature();
            Users user = (Users) session.getAttribute("userSession");
             String defaultavater =user.getAvatar();    //记录之前的用户头像

        if (nickName.trim() != "" && gender.trim() != "" && signature.trim() != "") {
            user.setNickName(nickName);
            user.setGender(gender);
            user.setSignature(signature);
            user.setAvatar(fileName);
            if(fileName==null){
               user.setAvatar(defaultavater);   //如果没有上传头像，则使用之前的头像
            }
            int result = usersService.updateUser(user);
            if (result > 0) {
                // 更新session
                session.setAttribute("userSession", user);
                apiResult.setCode(200);
            }else{
                apiResult.setCode(500);
            }
        }
            return apiResult;
        }

    //查询关注列表
    @GetMapping("/selectFollow")
    @ResponseBody
    public List<Users> selectFollowUsers(HttpSession session){
        Users user = (Users) session.getAttribute("userSession");
        List<Users> users = usersService.selectFollowUsers(user.getUserId());
        session.setAttribute("followList",users);
        return users;
    }

    //查询是否关注
    @GetMapping("/isFollow")
    @ResponseBody
    public Integer isFollow(String userName,HttpSession session){
        Users user = (Users) session.getAttribute("userSession");
        List<Users> userList = usersService.selectFollowUsers(user.getUserId());
        for (Users users:userList) {
            if(users.getUserName().equals(userName))
                return 1;
        }
        return 0;
    }

    //查询粉丝列表
    @GetMapping("/selectFans")
    @ResponseBody
    public List<Users> selectFans(HttpSession session){
        Users user = (Users) session.getAttribute("userSession");
        List<Users> users = usersService.selectFans(user.getUserId());
        session.setAttribute("fansList",users);
        return users;
    }

    //根据id关注用户
    @PostMapping("/follow")
    @ResponseBody
    public int followById(String fuId,HttpSession session,Integer status){
        Users user = (Users) session.getAttribute("userSession");
        Integer userId = user.getUserId();
        return usersService.followById(userId,fuId,status);
    }

    //查询关注的吧列表
    @GetMapping("/selectFollowBar")
    @ResponseBody
    public List<Map> selectFollowBar(HttpSession session){
        Users user = (Users) session.getAttribute("userSession");
        List<Map> followBarList = usersService.selectFollowBar(user.getUserId());
        session.setAttribute("followBarList",followBarList);
        return followBarList;
    }

    //根据id关注贴吧
    @PostMapping("/followbar")
    @ResponseBody
    public void followBarById(String barId,HttpSession session,Integer status){
        Users user = (Users) session.getAttribute("userSession");
        Integer userId = user.getUserId();
        usersService.followBarById(userId,barId,status);
    }

    //根据username查询用户
    @GetMapping("/selectUserByUserName")
    @ResponseBody
    public Map selectUserByUserName(String userName,HttpSession session){
        Users user = usersService.findUsersByUserName(userName);
        session.setAttribute("personInfo",user);
        Map countMap = usersService.selectCount(user.getUserId());
        session.setAttribute("usercountMap",countMap);
        return countMap;
    }

    //查询用户收藏列表
    @GetMapping("/selectMyCollection")
    @ResponseBody
    public List<Map> selectMyCollection(Integer userId,HttpSession session) {
        List<Map> collectionList =  usersService.selectMyCollection(userId);
        session.setAttribute("collectionList",collectionList);
        return collectionList;
    }

    //查询浏览历史
    @GetMapping("/selectHistory")
    @ResponseBody
    public List<Map> selectHistory(Integer status,HttpSession session){
        Users user = (Users) session.getAttribute("userSession");
        List<Map> historyList = usersService.selectHistory(user.getUserId(),status);
//        if(historyList.size()!=0)
            session.setAttribute("historyList",historyList);
        return historyList;
    }

    //清空浏览历史
    @GetMapping("/clearHistory")
    @ResponseBody
    public String clearHistory(HttpSession session){
        Users user = (Users) session.getAttribute("userSession");
        session.removeAttribute("historyList");
        return usersService.clearHistory(user.getUserId())>0?"success":"faild";
    }
}
