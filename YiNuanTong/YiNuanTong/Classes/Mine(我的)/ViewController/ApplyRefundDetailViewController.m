//
//  ApplyRefundDetailViewController.m
//  YiNuanTong
//
//  Created by 纪高飞 on 17/1/13.
//  Copyright © 2017年 纪高飞. All rights reserved.
//

#import "ApplyRefundDetailViewController.h"
#import "YNTUITools.h"
#import "SecondBuyViewController.h"
@interface ApplyRefundDetailViewController ()

@end

@implementation ApplyRefundDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = self.titleName;
    self.view.backgroundColor = [UIColor whiteColor];
   // 加载视图
    [self setUpChildrenViews];
}

/**
 *加载视图
 */
- (void)setUpChildrenViews
{
    
    // 创建图片
    UIImageView *picView = [YNTUITools createImageView:CGRectMake(45 *kPlus *kWidthScale, 46 *kPlus *kHeightScale + 64 , KScreenW - 2 *45*kPlus *kWidthScale, 330 *kHeightScale) bgColor:nil imageName:@"文字"];
    [self.view addSubview:picView];
    // 创建线图片
    UIImageView *linepicView = [YNTUITools createImageView:CGRectMake(50 *kPlus *kWidthScale, 46 *kPlus *kHeightScale + 50 *kHeightScale + 64+330, KScreenW - 2 *50*kPlus *kWidthScale, 1) bgColor:nil imageName:@"分割线-虚线"];
    [self.view addSubview:linepicView];
    
    // 创建拨打电话按钮
    UIButton *callButton = [YNTUITools createButton:CGRectMake(50*kWidthScale *kPlus, 445 *kHeightScale + 64, KScreenW - 100 *kPlus *kWidthScale , 150 *kPlus *kHeightScale) bgColor:nil title:nil titleColor:nil action:@selector(callButtonAction:) vc:self];
    [callButton setBackgroundImage:[UIImage imageNamed:@"电话图标"] forState:UIControlStateNormal];
    [self.view addSubview:callButton];
    
}
#pragma mark - 拨打电话事件
- (void)callButtonAction:(UIButton *)sender
{
    NSLog(@"点击的是打电话按钮");
    UIWebView *webView = [[UIWebView alloc]init];
    [sender addSubview:webView];
    NSString *str = @"tel://400-7713-123";
    NSURL *url = [NSURL URLWithString:str];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [webView loadRequest:request];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
  
}


@end
