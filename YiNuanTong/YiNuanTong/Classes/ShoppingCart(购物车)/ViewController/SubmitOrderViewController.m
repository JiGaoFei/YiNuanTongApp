//
//  SubmitOrderViewController.m
//  YiNuanTong
//
//  Created by 纪高飞 on 16/12/27.
//  Copyright © 2016年 纪高飞. All rights reserved.
//

#import "SubmitOrderViewController.h"
#import "YNTUITools.h"
#import "PayOderViewController.h"
#import "PayDetailViewController.h"
@interface SubmitOrderViewController ()

@end

@implementation SubmitOrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"提交订单成功";
    self.view.backgroundColor = RGBA(249, 249, 249, 1);
    
    
    // 加载子视图
    [self setUpChildrenViews];
    
}

/**
 *加载子视图
 */
- (void)setUpChildrenViews
{
    // 创建底部视图
    UIView *bigView = [[UIView alloc]initWithFrame:CGRectMake(0, 72 *kHeightScale, KScreenW, 260 *kHeightScale)];
    bigView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bigView];
    // 创建图标
    UIImageView *imgView = [[UIImageView alloc]initWithFrame:CGRectMake(KScreenW/ 2 - 20*kWidthScale, 25*kHeightScale, 40*kWidthScale, 40*kHeightScale)];
      imgView.image = [UIImage imageNamed:@"对勾"];
    [bigView addSubview:imgView];
    
    // 创建lab
    UILabel *creatOrderLab = [YNTUITools createLabel:CGRectMake(KScreenW/ 2  - 60*kWidthScale , CGRectGetMaxY(imgView.frame) + 10*kHeightScale, 120*kWidthScale, 18*kHeightScale) text:@"创建订单成功" textAlignment:NSTextAlignmentCenter textColor:nil bgColor:nil font:18];
    if (KScreenW == 320) {
        creatOrderLab.font = [UIFont systemFontOfSize:16];
    }
    [bigView addSubview:creatOrderLab];
    
  
    // 创建订货单lab
      NSString *oderNum = [NSString stringWithFormat:@"订单编号:%@",self.order_sn];
    UILabel *orderGoodsLab = [YNTUITools createLabel:CGRectMake(116 *kPlus *kWidthScale, CGRectGetMaxY(creatOrderLab.frame) +15*kHeightScale , KScreenW - 2 *kPlus *116*kWidthScale, 15*kHeightScale) text:oderNum textAlignment:NSTextAlignmentCenter textColor:CGRGray bgColor:nil font:15];
    if (KScreenW == 320) {
        orderGoodsLab.font = [UIFont systemFontOfSize:13];
    }
    [bigView addSubview:orderGoodsLab];
    
    
    // 创建moneylab
    NSString *amount = [NSString stringWithFormat:@"应付金额:%@",self.order_amount];
    UILabel *moneyLab = [YNTUITools createLabel:CGRectMake(KScreenW/ 2 - 60*kWidthScale    ,CGRectGetMaxY(orderGoodsLab.frame) +15*kHeightScale , 120*kWidthScale, 15*kHeightScale) text:amount textAlignment:NSTextAlignmentCenter textColor:CGRGray bgColor:nil font:14];
    if (KScreenW == 320) {
        moneyLab.font = [UIFont systemFontOfSize:12];
    }
    [bigView addSubview:moneyLab];
    
    // 创建线lineView
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(moneyLab.frame)+ 20 *kHeightScale, KScreenW, 1)];
    lineView.backgroundColor = CGRGray;
    [bigView addSubview:lineView];
    
    // 创建完成btn
    UIButton *completeBtn = [YNTUITools createButton:CGRectMake(81*kPlus*kWidthScale, 210*kHeightScale, 115*kWidthScale, 37*kHeightScale) bgColor:nil title:nil titleColor:nil action:@selector(completeBtnAction:) vc:self];
    UIImage *completeImg = [UIImage imageNamed:@"完成按钮"];
    completeImg = [completeImg imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [completeBtn setImage:completeImg forState:UIControlStateNormal];
    [bigView addSubview:completeBtn];
    // 创建付款btn
    UIButton *payBtn = [YNTUITools createButton:CGRectMake(215*kWidthScale, 210*kHeightScale, 115*kWidthScale, 37*kHeightScale) bgColor:nil title:nil titleColor:nil action:@selector(payBtnAction:) vc:self];
    UIImage *payImg = [UIImage imageNamed:@"付款按钮"];
  payImg = [payImg imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [payBtn setImage:payImg forState:UIControlStateNormal];

    [bigView addSubview:payBtn];


    
}
#pragma mark - 按钮点击事件
// 完成按钮的点击
- (void)completeBtnAction:(UIButton *)sender
{
    NSLog(@"我是完成");
    [self.navigationController popViewControllerAnimated:YES];
   }
//支付按钮的点击
- (void)payBtnAction:(UIButton *)sender
{
   
    NSLog(@"我是支付");
    PayOderViewController *payOrderVC = [[PayOderViewController alloc]init];
    payOrderVC.order_amount = self.order_amount;
    payOrderVC.order_sn = self.order_sn;
    payOrderVC.order_id = self.order_id;
    [self.navigationController pushViewController:payOrderVC animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
