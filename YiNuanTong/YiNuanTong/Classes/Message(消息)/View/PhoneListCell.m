//
//  PhoneListCell.m
//  YiNuanTong
//
//  Created by 纪高飞 on 16/12/21.
//  Copyright © 2016年 纪高飞. All rights reserved.
//

#import "PhoneListCell.h"
#import "YNTUITools.h"
@implementation PhoneListCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if ([super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setUpChildrenViews];
        self.callBtn.tag = 1810;
    }
    return  self;
}
/**
 *创建子视图
 */
- (void)setUpChildrenViews
{
    // 创建图片
    self.imgView = [YNTUITools createImageView:CGRectMake(35 *kWidthScale,10 *kHeightScale, 94 *kPlus *kWidthScale ,94 *kPlus *kWidthScale) bgColor:nil imageName:nil];

  
    [self.contentView addSubview:self.imgView];
    // 创建title
    self.titleLab = [YNTUITools createLabel:CGRectMake(90 *kWidthScale, 35 *kPlus *kHeightScale, 160 *kWidthScale, 20 *kHeightScale) text:nil textAlignment:NSTextAlignmentLeft textColor:nil bgColor:[UIColor whiteColor] font:15];
    if (KScreenW == 320) {
        self.titleLab.font = [UIFont systemFontOfSize:13];
    }
    [self.contentView addSubview:self.titleLab];
    
    
    // 创建contentLab
    self.contentLab = [YNTUITools createLabel:CGRectMake(90 *kWidthScale, (35 *kPlus + 20  + 10) *kHeightScale, KScreenW/2 *kWidthScale , 12 *kHeightScale) text:nil textAlignment:NSTextAlignmentLeft textColor:[UIColor grayColor] bgColor:[UIColor whiteColor] font:12];
    if (KScreenW == 320) {
        self.contentLab.font = [UIFont systemFontOfSize:10];
    }
    [self.contentView addSubview:self.contentLab];
    
    self.callBtn = [YNTUITools createButton:CGRectMake(KScreenW - (32 +36) *kWidthScale,38 *kPlus *kHeightScale, 32 *kWidthScale, 32 *kWidthScale) bgColor:nil title:nil titleColor:nil action:@selector(callBtnClicked:) vc:self];
    UIImage *img = [UIImage imageNamed:@"电话咨询"];
    img = [img imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [self.callBtn setImage:img forState:UIControlStateNormal];
    [self.contentView addSubview:self.callBtn];
    
}
/**
 *按钮的点击事件
 */

- (void)callBtnClicked:(UIButton *)sender
{
    if (self.buttonClicked) {
        self.buttonClicked(sender.tag);
    }
}
@end
