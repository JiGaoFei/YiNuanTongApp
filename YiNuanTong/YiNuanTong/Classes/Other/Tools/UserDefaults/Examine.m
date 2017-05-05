//
//  Examine.m
//  YiNuanTong
//
//  Created by 1暖通商城 on 2017/3/1.
//  Copyright © 2017年 纪高飞. All rights reserved.
//

#import "Examine.h"
#import "NSString+DocumentFilePath.h"
#define kAccountFileName @"phone"
@implementation Examine
+(instancetype)currentAccount
{
    static Examine *account;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSString *filePath = [NSString filePathWithName:kAccountFileName];
        
        account = [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
        
        if(!account){
            account =  [[Examine alloc] init];
        }
        
    });
    return account;
}


//保存登录信息
-(void)saveLoginInfo:(NSString *)phone
{
    
    self.phone = phone;
   
    NSString *filePath = [NSString filePathWithName:kAccountFileName];
    [NSKeyedArchiver archiveRootObject:self toFile:filePath];
    
    
    
}
// 修改用户信息的方法
- (void)updateUserInfomation:(NSString *)phone
{
    
    self.phone = phone;

    NSString *filePath = [NSString filePathWithName:kAccountFileName];
    [NSKeyedArchiver archiveRootObject:self toFile:filePath];
}


#pragma mark ---coding
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init]) {
       
        self.phone= [aDecoder decodeObjectForKey:@"phone"];
        
        
    }
    return self;
}
- (void)encodeWithCoder:(NSCoder *)aCoder
{
    
    [aCoder encodeObject:self.phone forKey:@"phone"];
   
    
}

@end
