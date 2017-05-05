//
//  UserInfo.m
//  YiNuanTong
//
//  Created by 纪高飞 on 17/2/5.
//  Copyright © 2017年 纪高飞. All rights reserved.
//

#import "UserInfo.h"
#import "NSString+DocumentFilePath.h"
#define kAccountFileName @"accountInfo"
@implementation UserInfo
+(instancetype)currentAccount
{
    static UserInfo *account;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSString *filePath = [NSString filePathWithName:kAccountFileName];
        
        account = [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
        
        if(!account){
            account =  [[UserInfo alloc] init];
        }

    });
    return account;
}
//保存登录信息
-(void)saveLoginInfo:(NSDictionary *)info withPassword:(NSString *)password withUserName:(NSString *)userName
{
    self.msg =info[@"msg"];
    self.username = info[@"username"];
    self.address = info[@"address"];
    self.avatar = info[@"avatar"];
    self.amount = info[@"amount"];
    self.fax= info[@"fax"];
    self.huanxin_id = info[@"huanxin_id"];
    self.phone = info[@"phone"];
    self.realname = info[@"realname"];
    self.tel = info[@"tel"];
    self.user_id = info[@"user_id"];
    self.username=info[@"user_name"];
    self.mendian1 = info[@"mendian1"];
    self.mendian2 = info[@"mendian2"];
    self.idcardfront =info[@"idcardfront"];
    self.idcardback =info[@"idcardback"];
    self.zhizhao =info[@"zhizhao"];
    self.yao_num = info[@"yao_num"];
    self.groupid = info[@"groupid"];
    self.bname = info[@"bname"];
    NSString *filePath = [NSString filePathWithName:kAccountFileName];
    [NSKeyedArchiver archiveRootObject:self toFile:filePath];
    


}
// 修改用户信息的方法
- (void)updateUserInfomation:(NSDictionary *)userInfomation
{
    self.username = userInfomation[@"username"];
    self.address = userInfomation[@"address"];
    self.avatar = userInfomation[@"avatar"];
    self.amount = userInfomation[@"amount"];
    self.fax= userInfomation[@"fax"];
    self.huanxin_id = userInfomation[@"huanxin_id"];
    self.phone = userInfomation[@"phone"];
    self.realname = userInfomation[@"realname"];
    self.tel = userInfomation[@"tel"];
    self.user_id = userInfomation[@"user_id"];
    self.username=userInfomation[@"user_name"];
    NSString *filePath = [NSString filePathWithName:kAccountFileName];
    [NSKeyedArchiver archiveRootObject:self toFile:filePath];
}
- (void)saveBage:(NSString *)badgeNum
{
    self.badge=badgeNum;
    NSString *filePath = [NSString filePathWithName:kAccountFileName];
    [NSKeyedArchiver archiveRootObject:self toFile:filePath];
}
// 存储头像
- (void)updateHeadImage:(NSString *)headImageString
{
    self.avatar = nil;
    self.avatar = headImageString;
    NSString *filePath = [NSString filePathWithName:kAccountFileName];
    [NSKeyedArchiver archiveRootObject:self toFile:filePath];

}
// 根据url获取图片
- (UIImage *)getImageFromURL:(NSString *)fileURL
{
    UIImage *result = [[UIImage alloc]init];
    NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:fileURL]];
    result = [UIImage imageWithData:data];
    return result;
}
-(NSString *)currentMsg{
    return _info;
}

-(NSString *)currentCode{
    return _msg;
}

-(BOOL)isLogin{
    /*
     if ([self.info isEqualToString:@"no error"]||[self.error_code isEqualToString:@"0"]||[self.msg isEqualToString:@"ok"]) {
     return YES;
     }
     */
    if ([self.msg isEqualToString:@"success"]) {
        return YES;
    }
    
    return NO;
}



//退出登录
-(void)logOut
{
    self.msg = nil;
    self.username = nil;
    self.address = nil;
    self.avatar =nil;
    self.amount = nil;
    self.fax= nil;
    self.huanxin_id = nil;
    self.phone =nil;
    self.realname =nil;
    self.tel = nil;
    self.user_id =nil;
    self.username=nil;
    self.mendian1 = nil;
    self.mendian2 = nil;
    self.idcardback = nil;
    self.idcardfront = nil;
    self. badge = nil;
    self.yao_num = nil;
    self.groupid = nil;
    self.bname = nil;

    NSString *filePath = [NSString filePathWithName:kAccountFileName];
    [[NSFileManager defaultManager] removeItemAtPath:filePath error:nil];

}

#pragma mark ---coding
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init]) {
        self.msg = [aDecoder decodeObjectForKey:@"msg"];
        self.info = [aDecoder decodeObjectForKey:@"info"];
        self.address = [aDecoder decodeObjectForKey:@"address"];
        self.amount = [aDecoder decodeObjectForKey:@"amount"];

        self.avatar = [aDecoder decodeObjectForKey:@"avatar"];

        self.fax = [aDecoder decodeObjectForKey:@"fax"];

        self.huanxin_id = [aDecoder decodeObjectForKey:@"huanxin_id"];
        self.phone= [aDecoder decodeObjectForKey:@"phone"];

        self.realname = [aDecoder decodeObjectForKey:@"realname"];

        self.tel = [aDecoder decodeObjectForKey:@"tel"];
          self.user_id = [aDecoder decodeObjectForKey:@"user_id"];
          self.username = [aDecoder decodeObjectForKey:@"username"];
        self.userHeadImage=[aDecoder decodeObjectForKey:@"userHeadImage"];
        self.mendian1 = [aDecoder decodeObjectForKey:@"mendian1"];
        self.mendian2 = [aDecoder decodeObjectForKey:@"mendian2"];
        self.idcardback = [aDecoder decodeObjectForKey:@"idcardback"];
        self.idcardfront =[aDecoder decodeObjectForKey:@"idcardfront"];
        self.zhizhao =[aDecoder decodeObjectForKey:@"zhizhao"];
        self.badge =[aDecoder decodeObjectForKey:@"badge"];
        self.groupid =[aDecoder decodeObjectForKey:@"groupid"];
        self.yao_num =[aDecoder decodeObjectForKey:@"yao_num"];
        self.bname =[aDecoder decodeObjectForKey:@"bname"];


    }
    return self;
}
- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.msg forKey:@"msg"];
    [aCoder encodeObject:self.address forKey:@"address"];
    [aCoder encodeObject:self.info forKey:@"info"];
    [aCoder encodeObject:self.amount forKey:@"amount"];
    [aCoder encodeObject:self.avatar forKey:@"avatar"];
    [aCoder encodeObject:self.fax  forKey:@"fax"];
    [aCoder encodeObject:self.huanxin_id forKey:@"huanxin_id"];
    [aCoder encodeObject:self.phone forKey:@"phone"];
    [aCoder encodeObject:self.realname forKey:@"realname"];
    [aCoder encodeObject:self.tel forKey:@"tel"];
    [aCoder encodeObject:self.user_id forKey:@"user_id"];
    [aCoder encodeObject:self.username forKey:@"username"];
    [aCoder encodeObject:self.userHeadImage forKey:@"userHeadImage"];
     [aCoder encodeObject:self.mendian1 forKey:@"mendian1"];
     [aCoder encodeObject:self.mendian2 forKey:@"mendian2"];
     [aCoder encodeObject:self.idcardback forKey:@"idcardback"];
     [aCoder encodeObject:self.idcardfront forKey:@"idcardfront"];
     [aCoder encodeObject:self.zhizhao forKey:@"zhizhao"];
     [aCoder encodeObject:self.badge forKey:@"badge"];
     [aCoder encodeObject:self.yao_num forKey:@"yao_num"];
     [aCoder encodeObject:self.bname forKey:@"bname"];
     [aCoder encodeObject:self.groupid forKey:@"groupid"];

}
@end
