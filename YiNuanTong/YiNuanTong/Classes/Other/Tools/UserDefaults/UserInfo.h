//
//  UserInfo.h
//  YiNuanTong
//
//  Created by 纪高飞 on 17/2/5.
//  Copyright © 2017年 纪高飞. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface UserInfo : NSObject<NSCoding>
/**返回码*/
@property (nonatomic,copy) NSString  * msg;
/**返回提示信息*/
@property(nonatomic,copy)NSString *info;
/**地址*/
@property(nonatomic,copy)NSString *address;
/**账户余额*/
@property(nonatomic,copy)NSString *amount;
/**头像路径*/
@property(nonatomic,copy)NSString *avatar;
/**传真*/
@property(nonatomic,copy)NSString *fax;
/**环信id*/
@property(nonatomic,copy)NSString *huanxin_id;
/**手机*/
@property(nonatomic,copy)NSString *phone;
/**用户id*/
@property(nonatomic,copy)NSString *user_id;
/**公司名字*/
@property(nonatomic,copy)NSString *realname;
/**用户名*/
@property (nonatomic,copy) NSString  * username;
/**固定电话*/
@property (nonatomic,copy) NSString  * tel;
/** 头像路径*/
@property (nonatomic,copy) NSString *userHeadImage;
/**营业执照*/
@property (nonatomic,copy) NSString *zhizhao;
/**身份证正面*/
@property (nonatomic,copy) NSString *idcardfront;
/**身份证反面*/
@property (nonatomic,copy) NSString *idcardback;
/**店铺形象*/
@property (nonatomic,copy) NSString *mendian1;
/**店铺形象*/
@property (nonatomic,copy) NSString *mendian2;
/**订单角标*/
@property (nonatomic,copy) NSString *badge;
/**邀请码*/
@property (nonatomic,copy) NSString *yao_num;
/**品牌名*/
@property (nonatomic,copy) NSString *bname;
/**当为14时显示邀请码*/
@property (nonatomic,copy) NSString *groupid;

+(instancetype)currentAccount;

-(NSString *)currentMsg;

-(NSString *)currentCode;
//保存登录信息
-(void)saveLoginInfo:(NSDictionary *)info withPassword:(NSString *)password withUserName:(NSString *)userName;
// 修改用户信息的方法
- (void)updateUserInfomation:(NSDictionary *)userInfomation;
// 存储头像
- (void)updateHeadImage:(NSString *)headImageString;
// 根据url获取图片
- (UIImage *)getImageFromURL:(NSString *)fileURL;
//判断是否登陆
-(BOOL)isLogin;

//退出登录
-(void)logOut;
// 订单角标
- (void)saveBage:(NSString *)badgeNum;

@end
