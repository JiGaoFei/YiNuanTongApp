//
//  ReviewProgressViewController.m
//  YiNuanTong
//
//  Created by 纪高飞 on 16/12/13.
//  Copyright © 2016年 纪高飞. All rights reserved.
//

#import "ReviewProgressViewController.h"
#import "YNTUITools.h"
#import "YNTNetworkManager.h"
#import "Examine.h"
@interface ReviewProgressViewController ()

@end

@implementation ReviewProgressViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (self.status == 0) {
        [self setUpChildrenViews];
    }else{
        [self setUpSuccessChildrenViews];
    }

}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
  //  [self setUpSuccessChildrenViews];

}


/**
 *创建子视图审核中
 */
- (void)setUpChildrenViews
{
    // 创建导航栏
    UIView *navView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, KScreenW, 64)];
    navView.backgroundColor = RGBA(18, 122, 203, 1);
    
    [self.view addSubview:navView];
    
    // 创建审核进度lab
    UILabel *titleLab = [YNTUITools createLabel:CGRectMake(KScreenW /2 -40, 20, 80, 40) text:@"审核中..." textAlignment:NSTextAlignmentCenter textColor:[UIColor whiteColor] bgColor:nil font:17];
    [self.view addSubview:titleLab];

        // 创建返回btn
    UIButton *backBtn = [YNTUITools createButton:CGRectMake(21.5, 20, 25, 32) bgColor: nil title:nil titleColor:nil action:@selector(backBtnAction:) vc:self];
    UIImage *backImg = [UIImage imageNamed:@"返回箭头"];
    backImg = [backImg imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [backBtn setImage:backImg forState:UIControlStateNormal];
    
    [self.view addSubview:backBtn];

   //  创建插图
    UIImageView  *illustrationView = [YNTUITools createImageView:CGRectMake(82 *kPlus *kWidthScale, 82 *kPlus+ 64,( KScreenW - 82 *kPlus *2*kWidthScale) ,  (KScreenW - 82 *kPlus *2 *kWidthScale) ) bgColor:nil imageName:@"插图"];
    [self.view addSubview:illustrationView];
    //  创建申请已提交
    UIImageView  *applyView = [YNTUITools createImageView:CGRectMake(44 *kPlus, 82 *kPlus  +(KScreenW - 82 *kPlus *2 *kWidthScale) *kWidthScale + 85 *kPlus+ 64, KScreenW - 84 *kPlus*kWidthScale , 171 *kPlus) bgColor:nil imageName:@"申请已提交"];
    [self.view addSubview:applyView];

    //  创建审核周期
    UIImageView  *reviewView =  [YNTUITools createImageView:CGRectMake(44 *kPlus, 540 *kHeightScale, (KScreenW - 84 *kPlus*kWidthScale ) , 171 *kPlus ) bgColor:nil imageName:@"审核周期"];
    [self.view addSubview:reviewView];

    
    
}
/**
 *创建子视图审核成功
 */
- (void)setUpSuccessChildrenViews
{
    // 创建导航栏
    UIView *navView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, KScreenW, 64)];
    navView.backgroundColor = RGBA(18, 122, 203, 1);
    
    [self.view addSubview:navView];
    
    // 创建审核进度lab
    UILabel *titleLab = [YNTUITools createLabel:CGRectMake(KScreenW /2 -40, 20, 80, 40) text:@"审核通过" textAlignment:NSTextAlignmentCenter textColor:[UIColor whiteColor] bgColor:nil font:17];
    [self.view addSubview:titleLab];
    
    
    
    
    // 创建返回btn
    UIButton *backBtn = [YNTUITools createButton:CGRectMake(21.5, 20, 25, 32) bgColor: nil title:nil titleColor:nil action:@selector(backBtnAction:) vc:self];
    UIImage *backImg = [UIImage imageNamed:@"返回"];
    backImg = [backImg imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [backBtn setImage:backImg forState:UIControlStateNormal];
    
    [self.view addSubview:backBtn];
    
    //  创建插图
    UIImageView  *illustrationView = [YNTUITools createImageView:CGRectMake(87*kWidthScale, 82 *kPlus+ 64, 398*kPlus *kWidthScale, 423*kPlus*kHeightScale) bgColor:nil imageName:@"插图1"];
    [self.view addSubview:illustrationView];
    //  创建申请已提交
    UIImageView  *applyView = [YNTUITools createImageView:CGRectMake(44 *kPlus, 82 *kPlus  + 423*kPlus*kHeightScale + 85 *kPlus+ 64, KScreenW - 84 *kPlus , 171 *kPlus) bgColor:nil imageName:@"审核通过"];
    [self.view addSubview:applyView];
    
    UILabel *contentLab = [YNTUITools createLabel:CGRectMake(45, 10, 150, 20) text:@"恭喜您通过审核!" textAlignment:NSTextAlignmentLeft textColor:[UIColor whiteColor] bgColor:nil font:17.0];
    [applyView addSubview:contentLab];
    
    
    
    
}
#pragma mark - 点击事件
- (void)backBtnAction:(UIButton *)sender
{
    NSLog(@"点击的是审核进度的返回");
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
