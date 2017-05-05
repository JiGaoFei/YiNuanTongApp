//
//  OrderNewDetailFooterView.m
//  YiNuanTong
//
//  Created by 1暖通商城 on 2017/4/7.
//  Copyright © 2017年 纪高飞. All rights reserved.
//

#import "OrderNewDetailFooterView.h"
#import "YNTUITools.h"
@implementation OrderNewDetailFooterView
- (instancetype)initWithFrame:(CGRect)frame
{
    if ([super initWithFrame: frame]) {
        // 加载视图
        [self setUpChildrenViews];
    }
    return self;
}
// 创建视图
- (void)setUpChildrenViews
{
    self.goodNumberLab = [YNTUITools createLabel:CGRectMake(230 *kWidthScale, 10 *kHeightScale, 72 *kWidthScale, 12 *kHeightScale) text:@"共3种99件" textAlignment:NSTextAlignmentLeft textColor:nil bgColor:nil font:12 *kHeightScale];
    [self addSubview:self.goodNumberLab];
    
    self.goodPriceLab =[YNTUITools createLabel:CGRectMake(302 *kWidthScale, 10 *kHeightScale, 72 *kWidthScale, 12 *kHeightScale) text:@"¥9999.00" textAlignment:NSTextAlignmentLeft textColor:nil bgColor:nil font:12 *kHeightScale];
    
    self.goodPriceLab.textColor = [UIColor colorWithRed:247.0/255 green:87.0/255 blue:50.0/255 alpha:1.0];
    [self addSubview:self.goodPriceLab];
    
}

@end
