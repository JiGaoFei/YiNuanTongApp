//
//  AccountPayCell.m
//  YiNuanTong
//
//  Created by 纪高飞 on 16/12/30.
//  Copyright © 2016年 纪高飞. All rights reserved.
//

#import "AccountPayCell.h"
#import "YNTUITools.h"
@implementation AccountPayCell

 - (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if ([super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        // 加载视图
        [self setUpChildrenViews];
    }
    return self;
}
// 加载视图
- (void)setUpChildrenViews
{
    
// 创建nameLab
    self.nameLab = [YNTUITools createLabel:CGRectMake(43 *kPlus, 30, 230, 16) text:nil textAlignment:NSTextAlignmentLeft textColor:nil bgColor:nil font:16];
    [self.contentView addSubview:self.nameLab];
    
    // 创建时间lab
    self.timeLab = [YNTUITools createLabel:CGRectMake(43 *kPlus, 51, KScreenW / 2, 13) text:nil textAlignment:NSTextAlignmentLeft textColor:CGRGray bgColor:nil font:13];
    [self.contentView addSubview:self.timeLab];
    
    // 创建钱数lab
    self.priceLab = [YNTUITools createLabel:CGRectMake(KScreenW - 115, 35, 100, 15) text:nil textAlignment:NSTextAlignmentRight textColor:CGRGray bgColor:nil font:15];
    [self.contentView addSubview:self.priceLab];


    
    
}
@end
