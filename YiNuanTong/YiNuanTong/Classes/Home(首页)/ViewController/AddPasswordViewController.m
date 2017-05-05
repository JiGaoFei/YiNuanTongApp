//
//  AddPasswordViewController.m
//  YiNuanTong
//
//  Created by 1暖通商城 on 2017/3/1.
//  Copyright © 2017年 纪高飞. All rights reserved.
//

#import "AddPasswordViewController.h"
#import "NSString+MD5.h"
@interface AddPasswordViewController ()

@end

@implementation AddPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 加密
    /** base64 加密 
     基本原理:
     1.原本是 8个bit 一组表示数据,改为 6个bit一组表示数据,不足的部分补零,每 两个0 用 一个 = 表示
     2.  用base64 编码之后,数据长度会变大,增加了大约 1/3 左右.(8-6)/6
     
     3. 编码有个非常显著的特点,末尾有个 = 号
     */
   
    
    NSString *password = @"jigaofei";
   NSString *md5 =  [password stringToMD5:password];
    NSLog(@"%@",md5);
// b6f20720d6f6d6dcf8cf6fc0ceb269e9
   }

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
