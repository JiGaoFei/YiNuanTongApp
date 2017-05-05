//
//  MessageListCell.m
//  YiNuanTong
//
//  Created by 纪高飞 on 16/12/21.
//  Copyright © 2016年 纪高飞. All rights reserved.
//

#import "MessageListCell.h"
#import "YNTUITools.h"
@implementation MessageListCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if ([super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setUpChildrenViews];
    }
    return  self;
}
/**
 *创建子视图
 */
- (void)setUpChildrenViews
{
    // 创建图片
    self.imgView = [YNTUITools createImageView:CGRectMake(35 *kPlus *kWidthScale, 21 *kPlus *kHeightScale, 94 *kPlus *kWidthScale ,94 *kPlus *kWidthScale) bgColor:nil imageName:nil];
    self.imgView.layer.cornerRadius = 94 *kPlus/2 *kWidthScale;
    self.imgView.layer.masksToBounds = YES;
    [self.contentView addSubview:self.imgView];
    
    
    
    UIImageView *rowImgView = [YNTUITools createImageView:CGRectMake(KScreenW - (35 + 15)*kPlus *kWidthScale, 56 *kPlus *kHeightScale, 15*kPlus *kWidthScale ,27 *kPlus *kHeightScale) bgColor:nil imageName:@"箭头"];

    [self.contentView addSubview:rowImgView];

    // 创建title
    self.titleLab = [YNTUITools createLabel:CGRectMake(153 *kPlus *kWidthScale, 35 *kPlus *kHeightScale, KScreenW / 2 *kWidthScale, 15 *kHeightScale) text:nil textAlignment:NSTextAlignmentLeft textColor:nil bgColor:[UIColor whiteColor] font:15];
    if (KScreenW == 320) {
        self.titleLab.font = [UIFont systemFontOfSize:13];
    }
    [self.contentView addSubview:self.titleLab];
    
    
    // 创建contentLab
    self.contentLab = [YNTUITools createLabel:CGRectMake(153 *kPlus *kWidthScale, (35 *kPlus+27) *kHeightScale, KScreenW -90 *kWidthScale , 12 *kHeightScale) text:nil textAlignment:NSTextAlignmentLeft textColor:[UIColor grayColor] bgColor:[UIColor whiteColor] font:12];
    if (KScreenW == 320) {
        self.contentLab.font = [UIFont systemFontOfSize:10];
    }
    [self.contentView addSubview:self.contentLab];

    
    
}
@end
