//
//  ShopSectionFooterView.m
//  1暖通购物车列表
//
//  Created by 1暖通商城 on 2017/4/5.
//  Copyright © 2017年 纪高飞. All rights reserved.
//

#import "ShopSectionFooterView.h"
#import "YNTUITools.h"
// 宏定义当前屏幕的宽度
#define KScreenW [UIScreen mainScreen].bounds.size.width
// 宏定义当前屏幕的高度
#define kScreenH [UIScreen mainScreen].bounds.size.height
// 屏幕宽的比例
#define kWidthScale [UIScreen mainScreen].bounds.size.width / 375
// 屏幕高的比例
#define kHeightScale [UIScreen mainScreen].bounds.size.height / 667
@implementation ShopSectionFooterView
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

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
