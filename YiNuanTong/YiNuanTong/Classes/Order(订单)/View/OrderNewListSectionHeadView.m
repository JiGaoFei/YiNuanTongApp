//
//  OrderNewListSectionHeadView.m
//  YiNuanTong
//
//  Created by 1暖通商城 on 2017/4/12.
//  Copyright © 2017年 纪高飞. All rights reserved.
//

#import "OrderNewListSectionHeadView.h"

@implementation OrderNewListSectionHeadView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // 创建数据
        [self setUpChildrenViews];
    }
    return self;
}
- (void)setUpChildrenViews
{
    UIView *bagView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, KScreenW, 70 *kHeightScale)];
    
    bagView.backgroundColor = [UIColor whiteColor];
    // 创建订单编号
   self.orderSnLab = [[UILabel alloc]initWithFrame:CGRectMake(15 *kWidthScale, 10 *kHeightScale, 240 *kWidthScale, 20)];
    _orderSnLab.text = @"订单编号:2017040108520";
    [bagView addSubview:_orderSnLab];
    // 创建交易时间
    self.orderTimeLab = [[UILabel alloc]initWithFrame:CGRectMake(15 *kWidthScale, 35 *kHeightScale, 260 *kWidthScale, 20)];
    _orderTimeLab.text = @"交易时间:2017-04-05 10:18";
    [bagView addSubview:_orderTimeLab];
    // 交易状态
    self.statuLab = [[UILabel alloc]initWithFrame:CGRectMake(KScreenW - 90 *kWidthScale, 10 *kHeightScale, 80 *kWidthScale, 20 *kHeightScale)];
    _statuLab.textAlignment = NSTextAlignmentRight;
    _statuLab.text = @"已完成";
    _statuLab.textColor = [UIColor redColor];
    [bagView addSubview:_statuLab];
    
    // 创建按钮
    self.openBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _openBtn.frame = CGRectMake(KScreenW - 40 *kWidthScale, 35 *kHeightScale, 22 *kWidthScale, 22 *kWidthScale);
    [_openBtn addTarget:self action:@selector(openBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [bagView addSubview:_openBtn];
    [self addSubview:bagView];
}
// 点击事件
- (void)openBtnAction:(UIButton *)sender
{
    sender.selected = !sender.selected;
    if (sender.selected) {
        [sender setBackgroundImage:[UIImage imageNamed:@"arrow_after"] forState:UIControlStateNormal];
        if (self.openBtnBloock) {
            
            self.openBtnBloock(YES);
        }
    }else{
        [sender setBackgroundImage:[UIImage imageNamed:@"arrow_before"] forState:UIControlStateNormal];
        if (self.openBtnBloock) {
            
            self.openBtnBloock(NO);
        }

    }

}

@end
