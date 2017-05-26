//
//  CreditActiveViewController.m
//  YiNuanTong
//
//  Created by 纪高飞 on 16/12/26.
//  Copyright © 2016年 纪高飞. All rights reserved.
//

#import "CreditActiveViewController.h"
#import "YNTUITools.h"
@interface CreditActiveViewController ()

@end

@implementation CreditActiveViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"信用币激活界面";
    self.view.backgroundColor= [UIColor whiteColor];
    // 加载子视图
    [self setUpChildrenViews];
}
/**
 *加载子视图
 */
- (void)setUpChildrenViews
{
    
    UIView *bigView = [[UIView alloc]initWithFrame:CGRectMake(42 *kPlus *kWidthScale, (39 *kPlus + 64) *kHeightScale, KScreenW - 42 *kPlus *2 *kWidthScale, 520 *kPlus *kHeightScale)];
    bigView.backgroundColor = RGBA(83, 83, 83, 1);
    
    [self.view addSubview:bigView];
    
        // 创建图片
    UIImageView *imgView = [YNTUITools createImageView:CGRectMake(140 *kWidthScale, 59 *kPlus *kHeightScale, 85 *kPlus *kWidthScale, 85 *kPlus *kHeightScale) bgColor:nil imageName:@"表情"];
    [bigView addSubview:imgView];
    
    
    UILabel *contentLab = [YNTUITools createLabel:CGRectMake(60 *kWidthScale, 59 *kPlus *kHeightScale,KScreenW - 2* 80*kWidthScale, 260 *kPlus *kHeightScale) text:@"您暂时还不能使用此功能"  textAlignment:NSTextAlignmentCenter textColor:[UIColor whiteColor] bgColor:nil font:18.0];
    [bigView addSubview:contentLab];
    
    
    // 创建返回按钮
    UIButton *backBtn = [YNTUITools createButton:CGRectMake(KScreenW / 2 - 274 *kPlus/2 *kWidthScale, 364 *kHeightScale, 274 *kPlus  *kWidthScale , 76 *kPlus *kHeightScale) bgColor: CGRBlue title:@"返回" titleColor:[UIColor whiteColor] action:@selector(backBtnAction:) vc:self];
    backBtn.layer.cornerRadius = 15*kWidthScale;
    backBtn.layer.masksToBounds = YES;
    [self.view addSubview:backBtn];
    
}
- (void)backBtnAction:(UIButton *)sender
{
    NSLog(@"点击我要返回");
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
