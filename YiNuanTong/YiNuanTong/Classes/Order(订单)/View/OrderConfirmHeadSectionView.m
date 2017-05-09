//
//  OrderConfirmHeadSectionView.m
//  YiNuanTong
//
//  Created by 1暖通商城 on 2017/5/9.
//  Copyright © 2017年 纪高飞. All rights reserved.
//

#import "OrderConfirmHeadSectionView.h"

@implementation OrderConfirmHeadSectionView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // 创建视图
        [self setUpChildrenViews];
    }
    return self;
}

- (void)setUpChildrenViews
{  // 标题视图
    self.titleLab = [[UILabel alloc]initWithFrame:CGRectMake(15 *kWidthScale ,12*kHeightScale, 80*kWidthScale, 15 *kWidthScale)];
    [self addSubview:self.titleLab];
    // 旋转按钮
    self.roateBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.roateBtn.frame = CGRectMake(KScreenW - 30 *kWidthScale, 12*kHeightScale, 22*kWidthScale, 22 *kWidthScale);
    [self.roateBtn setImage:[UIImage imageNamed:@"arrow_before"] forState:UIControlStateNormal];
//   [self.roateBtn setBackgroundImage:[UIImage imageNamed:@"arrow_before"] forState:UIControlStateNormal];
    [self.roateBtn addTarget:self action:@selector(roateBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.roateBtn];
}
- (void)roateBtnAction:(UIButton *)sender
{
    if (self.roateBtnBlock) {
        self.roateBtnBlock();
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
