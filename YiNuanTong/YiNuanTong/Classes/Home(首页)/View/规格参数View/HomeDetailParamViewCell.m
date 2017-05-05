//
//  HomeDetailParamViewCell.m
//  YiNuanTong
//
//  Created by 1暖通商城 on 2017/4/20.
//  Copyright © 2017年 纪高飞. All rights reserved.
//

#import "HomeDetailParamViewCell.h"
#import "YNTUITools.h"

@implementation HomeDetailParamViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if ([super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
     // 加载视图
        [self setUpChildrienViews];
    }
    return self;
}
- (void)setUpChildrienViews
{  // 标题
    self.nameTitleLab = [YNTUITools createLabel:CGRectMake(15*kWidthScale, 10 *kHeightScale, 60 *kWidthScale, 13 *kHeightScale) text:@"材质" textAlignment:NSTextAlignmentLeft textColor:RGBA(167, 167, 167, 1) bgColor:nil font:13 *kHeightScale];
    [self.contentView addSubview:self.nameTitleLab];
    // 副标题
    self.nameSubtitleLab =  [YNTUITools createLabel:CGRectMake(124*kWidthScale, 10 *kHeightScale, 100 *kWidthScale, 13 *kHeightScale) text:@"材质" textAlignment:NSTextAlignmentLeft textColor:RGBA(103, 103, 103, 1) bgColor:nil font:13 *kHeightScale];
    [self.contentView addSubview:self.nameSubtitleLab];
    
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
