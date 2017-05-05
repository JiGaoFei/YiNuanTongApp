//
//  AccountCell.m
//  YiNuanTong
//
//  Created by 纪高飞 on 16/12/15.
//  Copyright © 2016年 纪高飞. All rights reserved.
//

#import "AccountCell.h"
#import "YNTUITools.h"
@implementation AccountCell
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

    // 创建lab
    self.accountLab = [YNTUITools createLabel:CGRectMake(10 *kWidthScale, 18 *kHeightScale, 120 *kWidthScale, 15 *kHeightScale) text:nil textAlignment:NSTextAlignmentLeft textColor:nil bgColor:nil font:15];
    if (KScreenW == 320) {
        self.accountLab.font = [UIFont systemFontOfSize:13];
    }
    [self.contentView addSubview:self.accountLab];
    
    // 创建图片
    self.accountDetailLab = [YNTUITools createLabel:CGRectMake(10 *kWidthScale, 35 *kHeightScale, 100 *kWidthScale, 12 *kHeightScale) text:nil textAlignment:NSTextAlignmentLeft textColor:CGRGray bgColor:nil font:12];
    if (KScreenW == 320) {
        self.accountDetailLab.font = [UIFont systemFontOfSize:10];
    }
    [self.contentView addSubview:self.accountDetailLab];
    // 创建乘着图片
    UIImageView *rowImageView = [YNTUITools createImageView:CGRectMake(170 *kWidthScale , 25 *kHeightScale, 15 *kPlus *kWidthScale, 27*kPlus *kHeightScale) bgColor:nil imageName:@"箭头"];
    [self.contentView addSubview:rowImageView];
    // 创建中间线
    self.lineLab = [YNTUITools createLabel:CGRectMake(185 *kWidthScale, 10 *kHeightScale, 2, 40*kHeightScale) text:nil textAlignment:NSTextAlignmentLeft textColor:nil bgColor:CGRGray font:12];
    [self.contentView  addSubview: self.lineLab];
    
}

@end
