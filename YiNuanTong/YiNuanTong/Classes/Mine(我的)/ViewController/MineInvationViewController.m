//
//  MineInvationViewController.m
//  YiNuanTong
//
//  Created by 1暖通商城 on 2017/4/28.
//  Copyright © 2017年 纪高飞. All rights reserved.
//

#import "MineInvationViewController.h"
#import "YNTUITools.h"
@interface MineInvationViewController ()

@end

@implementation MineInvationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"我的邀请";
    [self setUpChildrenViews];

}
// 加载视图
- (void)setUpChildrenViews
{
       UserInfo *userInfo = [UserInfo currentAccount];
    
    UILabel *nameLab = [YNTUITools createLabel:CGRectMake(KScreenW/2 - 50 *kWidthScale, 64+35*kHeightScale, 100 *kWidthScale, 20 *kHeightScale) text:@"我的品牌" textAlignment:NSTextAlignmentCenter textColor:nil bgColor:nil font:18 *kHeightScale];
     nameLab.text =[NSString stringWithFormat:@"品牌:%@",userInfo.bname];
     [self.view addSubview:nameLab];
    
    
    //my_invitation_my_brand
    UIImageView *imgView = [YNTUITools createImageView:CGRectMake(KScreenW/ 2 - 90 *kWidthScale, 64+65*kHeightScale, 180 *kWidthScale, 180 *kWidthScale) bgColor:nil imageName:@"my_invitation_my_brand"];
    [self.view addSubview:imgView];
    
    UILabel *mineLab =[YNTUITools createLabel:CGRectMake(99 *kWidthScale, 64+280*kHeightScale, 110 *kWidthScale, 20 *kHeightScale) text:@"我的邀请码:" textAlignment:NSTextAlignmentCenter textColor:nil bgColor:nil font:18 *kHeightScale];
    [self.view addSubview:mineLab];
    

    
    UILabel *invationSn =[YNTUITools createLabel:CGRectMake(215 *kWidthScale, 64+280*kHeightScale, 110 *kWidthScale, 20 *kHeightScale) text:userInfo.yao_num textAlignment:NSTextAlignmentLeft textColor:CGRBlue bgColor:nil font:18 *kHeightScale];
    [self.view addSubview:invationSn];

    
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
