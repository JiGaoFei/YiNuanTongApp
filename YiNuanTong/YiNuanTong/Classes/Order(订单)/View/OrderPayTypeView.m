//
//  OrderPayTypeView.m
//  YiNuanTong
//
//  Created by 1暖通商城 on 2017/4/7.
//  Copyright © 2017年 纪高飞. All rights reserved.
//

#import "OrderPayTypeView.h"

@implementation OrderPayTypeView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUpChildrenViews];
    }
    return self;
}
- (void)setUpChildrenViews
{
    // 支付宝
    UIImageView *imgeView1 = [[UIImageView alloc]initWithFrame:CGRectMake(15 *kWidthScale, 9*kHeightScale, 26 *kWidthScale, 26 *kWidthScale)];
    imgeView1.image = [UIImage imageNamed:@"alipay"];
    [self addSubview:imgeView1];
    UILabel *title1 = [[UILabel alloc]initWithFrame:CGRectMake(85 *kWidthScale, 12 *kHeightScale, 120 *kWidthScale, 20 *kHeightScale)];
    title1.font = [UIFont systemFontOfSize:15 *kHeightScale];
    title1.text = @"支付宝支付";
    [self addSubview:title1];
    self.aliPayBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.aliPayBtn.frame = CGRectMake(KScreenW - 35 *kWidthScale, 10 *kHeightScale, 18 *kWidthScale, 18 *kWidthScale) ;
    [self.aliPayBtn setBackgroundImage:[UIImage imageNamed:@"order_unchecked"] forState:UIControlStateNormal];
    [self.aliPayBtn addTarget:self action:@selector(aliPayBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_aliPayBtn];
    
    UILabel *linelab1 = [[UILabel alloc]initWithFrame:CGRectMake(0, 44 *kHeightScale, KScreenW, 1)];
    linelab1.backgroundColor =  RGBA(241, 241, 241, 1);
    [self addSubview:linelab1];
    
    // 微信支付
    UIImageView *imgeView2 = [[UIImageView alloc]initWithFrame:CGRectMake(17 *kWidthScale, 71*kHeightScale, 30 *kWidthScale, 26 *kWidthScale)];
    imgeView2.image = [UIImage imageNamed:@"wei_pay"];
    [self addSubview:imgeView2];
    UILabel *title2 = [[UILabel alloc]initWithFrame:CGRectMake(85 *kWidthScale, 74 *kHeightScale, 120 *kWidthScale, 20 *kHeightScale)];
    title2.font = [UIFont systemFontOfSize:15 *kHeightScale];
    title2.text = @"微信支付";
    [self addSubview:title2];
    self.weChatPayBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.weChatPayBtn.frame = CGRectMake(KScreenW - 35 *kWidthScale,72 *kHeightScale, 18 *kWidthScale, 18 *kWidthScale) ;
    [self.weChatPayBtn setBackgroundImage:[UIImage imageNamed:@"order_unchecked"] forState:UIControlStateNormal];
    [self.weChatPayBtn addTarget:self action:@selector(weChatPayBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_weChatPayBtn];
    UILabel *linelab2 = [[UILabel alloc]initWithFrame:CGRectMake(0, 106 *kHeightScale, KScreenW, 1)];
    linelab2.backgroundColor = RGBA(241, 241, 241, 1);
    [self addSubview:linelab2];
                            
}
// 支付宝支付
- (void)aliPayBtnAction:(UIButton *)sender
{
    NSLog(@"支付宝支付");
    if (self.aliPayBtnBlook) {
        self.aliPayBtnBlook();
    }
}
// 微信支付
- (void)weChatPayBtnAction:(UIButton *)sender
{
    NSLog(@"微信支付");
    if (self.weChatPayBtnBlook) {
        self.weChatPayBtnBlook();
    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
