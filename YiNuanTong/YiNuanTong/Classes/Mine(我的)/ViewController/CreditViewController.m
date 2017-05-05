//
//  CreditViewController.m
//  YiNuanTong
//
//  Created by 纪高飞 on 16/12/23.
//  Copyright © 2016年 纪高飞. All rights reserved.
//

#import "CreditViewController.h"
#import "YNTUITools.h"
#import "CreditActiveViewController.h"
@interface CreditViewController ()

@end

@implementation CreditViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title= @"信用币管理";
    self.view.backgroundColor =RGBA(249, 249, 249, 1);
    [self setUpChildrenViews];
 
}
- (void)setUpChildrenViews
{
    UIImageView *imgView =[[UIImageView alloc]initWithFrame:CGRectMake(0, 83 *kHeightScale, KScreenW, 230 *kHeightScale)];
    imgView.userInteractionEnabled = YES;
    imgView.image = [UIImage imageNamed:@"信用币管理"];
    [self.view addSubview:imgView];
    UIButton *activeBtn = [YNTUITools createButton:CGRectMake(115 *kWidthScale,170 *kHeightScale, 274 *kPlus *kWidthScale  , 76*kPlus *kHeightScale) bgColor:nil title:nil titleColor:nil action:@selector(activeBtnAction:) vc:self];
    [imgView addSubview:activeBtn];

    
}
- (void)activeBtnAction:(UIButton *)sender
{
    NSLog(@"我是立即激活");
    CreditActiveViewController *creditActiveVC = [[CreditActiveViewController alloc]init];
    [self.navigationController pushViewController:creditActiveVC animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
