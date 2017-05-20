//
//  OrderNewListSectionFooterView.m
//  YiNuanTong
//
//  Created by 1暖通商城 on 2017/4/12.
//  Copyright © 2017年 纪高飞. All rights reserved.
//

#import "OrderNewListSectionFooterView.h"
#import "YNTUITools.h"
@implementation OrderNewListSectionFooterView

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
    UIView *bagView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, KScreenW, 100 *kHeightScale)];
    
    bagView.backgroundColor = [UIColor whiteColor];
    // 创建数量lab
    self.goodNumLab = [[UILabel alloc]initWithFrame:CGRectMake(180*kWidthScale, 12 *kHeightScale, 100 *kWidthScale, 13)];
    _goodNumLab.text = @"共6种297件";
    [bagView addSubview:_goodNumLab];
    // 创建价钱lab
    self.goodMoneyLab = [[UILabel alloc]initWithFrame:CGRectMake(280*kWidthScale, 12 *kHeightScale, 80 *kWidthScale, 13)];
    _goodMoneyLab.text = @"9999.00";
    _goodMoneyLab.textColor = [UIColor redColor];
    [bagView addSubview:_goodMoneyLab];
    
    //  创建线
    UILabel *linLab = [[UILabel alloc]initWithFrame:CGRectMake(0, 39 *kHeightScale, KScreenW, 2)];
    linLab.backgroundColor =  RGBA(248, 248, 248, 1);
    [bagView addSubview:linLab];
    // 创建按钮
    
    self.deletOrderBtn = [YNTUITools createButton:CGRectMake(KScreenW - 233 *kWidthScale, 50 *kHeightScale, 103 *kWidthScale, 32 *kHeightScale) bgColor:RGBA(52, 162, 252, 1) title:@"" titleColor:[UIColor whiteColor] action:@selector(deleteOrderBtnAction:) vc:self];
    self.deletOrderBtn.layer.cornerRadius = 5;
    self.deletOrderBtn.layer.masksToBounds = YES;
    
    [bagView addSubview:_deletOrderBtn];
    
    self.seconBuyBtn = [YNTUITools createButton:CGRectMake(KScreenW - 120 *kWidthScale, 50 *kHeightScale, 103 *kWidthScale, 32 *kHeightScale) bgColor:RGBA(52, 162, 252, 1) title:@"" titleColor:[UIColor whiteColor] action:@selector(secondBuyBtnAction:) vc:self];
    self.seconBuyBtn.layer.cornerRadius = 5;
    self.seconBuyBtn.layer.masksToBounds = YES;
    [bagView addSubview:_seconBuyBtn];
  
    UILabel *lineLab = [[UILabel alloc]initWithFrame:CGRectMake(0, 104 *kHeightScale, KScreenW, 6*kHeightScale)];
    lineLab.backgroundColor =  RGBA(241, 241, 241, 1);
    [bagView addSubview:lineLab];
    [self addSubview:bagView];
}
#pragma 区尾按钮点击事件
- (void)deleteOrderBtnAction:(UIButton *)sender
{
    NSLog(@"点击的是删除");
    if (self.deletOrderBtnBloock) {
        self.deletOrderBtnBloock();
    }
}
- (void)secondBuyBtnAction:(UIButton *)sender
{
    NSLog(@"点击的是再次购买");
    if (self.secondBuyBtnBloock) {
        self.secondBuyBtnBloock();
    }
}




@end
