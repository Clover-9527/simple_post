/*
 Navicat Premium Data Transfer

 Source Server         : z
 Source Server Type    : MySQL
 Source Server Version : 80031
 Source Host           : localhost:3306
 Source Schema         : simple_post

 Target Server Type    : MySQL
 Target Server Version : 80031
 File Encoding         : 65001

 Date: 16/03/2023 21:16:29
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for bar
-- ----------------------------
DROP TABLE IF EXISTS `bar`;
CREATE TABLE `bar`  (
  `bar_id` int NOT NULL AUTO_INCREMENT COMMENT '吧ID',
  `bar_name` varchar(30) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '吧名',
  `pic_name` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '图片',
  PRIMARY KEY (`bar_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci COMMENT = '贴吧表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of bar
-- ----------------------------
INSERT INTO `bar` VALUES (1, '炉石传说', '429e43f7-a7ac-4117-b4b9-a3d29270c246.jpg');
INSERT INTO `bar` VALUES (2, '王者荣耀', 'b4f79aa5-e089-4879-87f1-07231b326b4e.jpg');
INSERT INTO `bar` VALUES (3, 'Java', 'f90406b9-492c-4631-9808-dd46cb339e2a.jpg');

-- ----------------------------
-- Table structure for collection
-- ----------------------------
DROP TABLE IF EXISTS `collection`;
CREATE TABLE `collection`  (
  `collection_id` int NOT NULL AUTO_INCREMENT COMMENT '收藏ID',
  `post_id` int NULL DEFAULT NULL COMMENT '帖子ID',
  `user_id` int NULL DEFAULT NULL COMMENT '用户ID',
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '收藏时间',
  PRIMARY KEY (`collection_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 13 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci COMMENT = '收藏表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of collection
-- ----------------------------
INSERT INTO `collection` VALUES (4, 62, 1, '2022-12-03 16:49:44');
INSERT INTO `collection` VALUES (6, 65, 1, '2022-12-15 23:25:31');
INSERT INTO `collection` VALUES (9, 62, 3, '2022-12-16 10:56:58');
INSERT INTO `collection` VALUES (11, 66, 1, '2022-12-16 14:03:11');
INSERT INTO `collection` VALUES (12, 62, 2, '2022-12-16 14:29:08');
INSERT INTO `collection` VALUES (13, 61, 1, '2022-12-16 14:35:37');

-- ----------------------------
-- Table structure for follow_bar
-- ----------------------------
DROP TABLE IF EXISTS `follow_bar`;
CREATE TABLE `follow_bar`  (
  `user_id` int NOT NULL COMMENT '用户ID',
  `bar_id` int NOT NULL COMMENT '吧ID',
  `exp` int(10) UNSIGNED ZEROFILL NULL DEFAULT 0000000006 COMMENT '缂佸繘鐛?',
  `level` tinyint(3) UNSIGNED ZEROFILL NULL DEFAULT 001 COMMENT '缁涘楠?',
  `deleted` int NULL DEFAULT 0 COMMENT '删除标识（0未删除，1已删除）',
  PRIMARY KEY (`user_id`, `bar_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci COMMENT = '关注的吧表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of follow_bar
-- ----------------------------
INSERT INTO `follow_bar` VALUES (1, 1, 0000000006, 001, 0);
INSERT INTO `follow_bar` VALUES (1, 2, 0000000006, 001, 0);
INSERT INTO `follow_bar` VALUES (1, 3, 0000000006, 001, 0);

-- ----------------------------
-- Table structure for follow_users
-- ----------------------------
DROP TABLE IF EXISTS `follow_users`;
CREATE TABLE `follow_users`  (
  `fid` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL COMMENT '用户ID',
  `follow_user_id` int NOT NULL COMMENT '关注用户ID',
  PRIMARY KEY (`fid`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 107 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci COMMENT = '关注的用户表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of follow_users
-- ----------------------------
INSERT INTO `follow_users` VALUES (76, 3, 1);
INSERT INTO `follow_users` VALUES (102, 1, 3);
INSERT INTO `follow_users` VALUES (103, 2, 1);
INSERT INTO `follow_users` VALUES (106, 1, 2);

-- ----------------------------
-- Table structure for history
-- ----------------------------
DROP TABLE IF EXISTS `history`;
CREATE TABLE `history`  (
  `history_id` int NOT NULL AUTO_INCREMENT COMMENT '历史ID',
  `post_id` int NULL DEFAULT NULL COMMENT '帖子ID',
  `user_id` int NULL DEFAULT NULL COMMENT '用户ID',
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`history_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 38 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci COMMENT = '历史表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of history
-- ----------------------------
INSERT INTO `history` VALUES (29, 65, 3, '2022-12-16 10:56:41');
INSERT INTO `history` VALUES (30, 62, 3, '2022-12-16 10:56:56');
INSERT INTO `history` VALUES (35, 65, 2, '2022-12-16 14:17:31');
INSERT INTO `history` VALUES (38, 62, 2, '2022-12-16 14:29:07');

-- ----------------------------
-- Table structure for post
-- ----------------------------
DROP TABLE IF EXISTS `post`;
CREATE TABLE `post`  (
  `post_id` int NOT NULL AUTO_INCREMENT COMMENT '帖子ID',
  `post_title` varchar(35) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '帖子标题',
  `content` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL COMMENT '帖子内容',
  `bar_id` int NULL DEFAULT NULL COMMENT '吧ID',
  `user_id` int NULL DEFAULT NULL COMMENT '用户ID',
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '发布时间',
  `secret` int NULL DEFAULT 0 COMMENT '0公开 1私密',
  `like_num` int(10) UNSIGNED ZEROFILL NULL DEFAULT 0000000000,
  `my_like` int(10) UNSIGNED ZEROFILL NULL DEFAULT 0000000000,
  PRIMARY KEY (`post_id`) USING BTREE,
  INDEX `post_bar_id_fk`(`bar_id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 72 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci COMMENT = '帖子表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of post
-- ----------------------------
INSERT INTO `post` VALUES (61, '事务的隔离级别有哪些？', 'ACID', 3, 2, '2022-12-15 16:47:46', 0, 0000000000, 0000000000);
INSERT INTO `post` VALUES (62, 'springmvc怎么放行静态资源？', '666', 3, 2, '2022-12-15 16:48:18', 0, 0000000000, 0000000000);
INSERT INTO `post` VALUES (63, '隐藏的帖子', '123123', 3, 2, '2022-12-15 16:48:45', 1, 0000000000, 0000000000);
INSERT INTO `post` VALUES (64, '123', '111', 3, 1, '2022-12-15 20:17:01', 0, 0000000000, 0000000000);
INSERT INTO `post` VALUES (65, '222', '123123', 2, 1, '2022-12-15 23:13:29', 1, 0000000000, 0000000000);
INSERT INTO `post` VALUES (66, 'ceshi', '123', 3, 3, '2022-12-16 11:00:23', 0, 0000000000, 0000000000);
INSERT INTO `post` VALUES (71, '1', 'lscs ', 1, 1, '2022-12-16 14:30:44', 0, 0000000000, 0000000000);

-- ----------------------------
-- Table structure for post_img
-- ----------------------------
DROP TABLE IF EXISTS `post_img`;
CREATE TABLE `post_img`  (
  `post_img_id` int NOT NULL AUTO_INCREMENT COMMENT '帖子图片ID',
  `pic_name` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '图片名称',
  `post_id` int NULL DEFAULT NULL COMMENT '帖子ID',
  PRIMARY KEY (`post_img_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 49 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci COMMENT = '帖子图片表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of post_img
-- ----------------------------
INSERT INTO `post_img` VALUES (44, '3c9cd397-081c-4669-bc51-40119a036847.jpg', 61);
INSERT INTO `post_img` VALUES (45, '0c2ffcb9-bc03-460a-b5b5-151f53860a5c.jpg', 61);
INSERT INTO `post_img` VALUES (46, 'dc4f6185-b38e-42e2-a55f-d5be59d98246.jpg', 61);
INSERT INTO `post_img` VALUES (47, '0905a49e-eabc-47bc-82b8-7ba759f4e8ec.jpg', 65);
INSERT INTO `post_img` VALUES (48, '87590a69-57aa-4805-aad7-037e54000504.jpg', 71);

-- ----------------------------
-- Table structure for post_like
-- ----------------------------
DROP TABLE IF EXISTS `post_like`;
CREATE TABLE `post_like`  (
  `user_id` int NOT NULL COMMENT '用户ID',
  `post_id` int NOT NULL COMMENT '帖子id',
  PRIMARY KEY (`user_id`, `post_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of post_like
-- ----------------------------

-- ----------------------------
-- Table structure for users
-- ----------------------------
DROP TABLE IF EXISTS `users`;
CREATE TABLE `users`  (
  `user_id` int NOT NULL AUTO_INCREMENT COMMENT '用户ID',
  `user_name` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '用户名',
  `password` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '密码',
  `nick_name` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '昵称',
  `phone` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '手机号',
  `gender` varchar(1) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '性别',
  `signature` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '个性签名',
  `avatar` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '头像',
  PRIMARY KEY (`user_id`) USING BTREE,
  UNIQUE INDEX `users_users_name_unique`(`user_name` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 25 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci COMMENT = '用户表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of users
-- ----------------------------
INSERT INTO `users` VALUES (1, 'u1', '1', 'u1', '132', '1', '1签名222', '80c9bc3a-66cf-4c10-aab6-15d6bd09e5c6.jpg');
INSERT INTO `users` VALUES (2, 'u2', '2', 'u2', '111', '1', '2签名', '');
INSERT INTO `users` VALUES (3, 'u3', '3', 'u3', '111', '1', '3签名', '');
INSERT INTO `users` VALUES (25, '1', '1', '1', NULL, '1', '', '');

SET FOREIGN_KEY_CHECKS = 1;
