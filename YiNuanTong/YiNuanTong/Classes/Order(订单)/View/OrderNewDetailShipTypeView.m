//
//  OrderNewDetailShipTypeView.m
//  YiNuanTong
//
//  Created by 1暖通商城 on 2017/4/13.
//  Copyright © 2017年 纪高飞. All rights reserved.
//

#import "OrderNewDetailShipTypeView.h"

@implementation OrderNewDetailShipTypeView

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
    // 物流免费
    UILabel *title1 = [[UILabel alloc]initWithFrame:CGRectMake(15 *kWidthScale, 12 *kHeightScale, 120 *kWidthScale, 20 *kHeightScale)];
    title1.font = [UIFont systemFontOfSize:15 *kHeightScale];
    title1.text = @"送货上门";
    [self addSubview:title1];
    self.mianfeiBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.mianfeiBtn.frame = CGRectMake(KScreenW - 35 *kWidthScale, 10 *kHeightScale, 18 *kWidthScale, 18 *kWidthScale) ;
    [self.mianfeiBtn setBackgroundImage:[UIImage imageNamed:@"order_unchecked"] forState:UIControlStateNormal];
    [self.mianfeiBtn addTarget:self action:@selector(mianfeiBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_mianfeiBtn];
    
  
    
    // 上门自取
    UILabel *title2 = [[UILabel alloc]initWithFrame:CGRectMake(15 *kWidthScale, 50 *kHeightScale, 120 *kWidthScale, 20 *kHeightScale)];
    title2.font = [UIFont systemFontOfSize:15 *kHeightScale];
    title2.text = @"到店自取";
    [self addSubview:title2];
    self.ziquBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.ziquBtn.frame = CGRectMake(KScreenW - 35 *kWidthScale,50 *kHeightScale, 18 *kWidthScale, 18 *kWidthScale) ;
    [self.ziquBtn setBackgroundImage:[UIImage imageNamed:@"order_unchecked"] forState:UIControlStateNormal];
    [self.ziquBtn addTarget:self action:@selector(ziquBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_ziquBtn];
    UILabel *linelab2 = [[UILabel alloc]initWithFrame:CGRectMake(0, 106 *kHeightScale, KScreenW, 1)];
    linelab2.backgroundColor =  RGBA(241, 241, 241, 1);
    [self addSubview:linelab2];
    
}
// 支付宝支付
- (void)mianfeiBtnAction:(UIButton *)sender
{
    NSLog(@"支付宝支付");
    if (self.mianfeiBtnBlook) {
        self.mianfeiBtnBlook();
    }
}
// 微信支付
- (void)ziquBtnAction:(UIButton *)sender
{
    NSLog(@"微信支付");
    if (self.ziquBtnBlook) {
        self.ziquBtnBlook();
    }
}


@end
