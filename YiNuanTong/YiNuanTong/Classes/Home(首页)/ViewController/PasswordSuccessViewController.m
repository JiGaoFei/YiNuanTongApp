//
//  PasswordSuccessViewController.m
//  YiNuanTong
//
//  Created by 纪高飞 on 16/12/29.
//  Copyright © 2016年 纪高飞. All rights reserved.
//

#import "PasswordSuccessViewController.h"
#import "YNTUITools.h"
#import "YNTNetworkManager.h"
#import "LoginViewController.h"
@interface PasswordSuccessViewController ()

@end

@implementation PasswordSuccessViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    // 加载子视图
    [self setUpChildrenViews];
}

/**
 *创建子视图
 */
- (void)setUpChildrenViews
{
    // 创建导航栏
    UIView *navView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, KScreenW, 64)];
    navView.backgroundColor = RGBA(18, 122, 203, 1);
    
    [self.view addSubview:navView];
    
    
    // 创建返回btn
    UIButton *backBtn = [YNTUITools createButton:CGRectMake(21.5, 20, 25, 32) bgColor: nil title:nil titleColor:nil action:@selector(backBtnAction:) vc:self];
    UIImage *backImg = [UIImage imageNamed:@"返回箭头"];
    backImg = [backImg imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [backBtn setImage:backImg forState:UIControlStateNormal];
    
    [self.view addSubview:backBtn];
    
    // 创建审核进度lab
    UILabel *titleLab = [YNTUITools createLabel:CGRectMake(KScreenW /2 -80, 20, 160, 40) text:@"密码设置成功" textAlignment:NSTextAlignmentCenter textColor:[UIColor whiteColor] bgColor:nil font:17];
    [self.view addSubview:titleLab];
    
    // 创建插图1
    UIImageView *illustraImageView = [YNTUITools createImageView:CGRectMake(KScreenW / 2 - 56, 126 *kPlus+ 64, 112, 112) bgColor:nil imageName:@"插图密码设置成功"];
    [self.view addSubview:illustraImageView];
     // 创建插图2
    UILabel  *passwordLab = [YNTUITools createLabel:CGRectMake(80, 254, KScreenW - 160, 18) text:@"恭喜您,密码设置成功" textAlignment:NSTextAlignmentCenter textColor:CGRGray bgColor:nil font:18];
    [self.view addSubview:passwordLab];
    
    
    // 创建下一步btn
    UIButton *loginBtn = [YNTUITools createButton:CGRectMake(43 *kPlus, 272+ 42, KScreenW -43 *2 *kPlus, 50) bgColor:RGBA(18, 122, 203, 1) title:@"立刻登陆" titleColor:[UIColor whiteColor] action:@selector(loginBtnAction:) vc:self];
    
        [self.view addSubview:loginBtn];
    }
#pragma mark - 点击事件
-(void)backBtnAction:(UIButton *)sender
{
    NSLog(@"点击返回");
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)loginBtnAction:(UIButton *)sender
{
    NSLog(@"我立刻登陆");
    UIViewController *vc =self.presentingViewController;
    
    //LoginViewController要跳转的界面
    
    while (![vc isKindOfClass:[LoginViewController class]]) {
                vc = vc.presentingViewController;
        
    }
    [vc dismissViewControllerAnimated:YES completion:nil];
    

   
   
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
