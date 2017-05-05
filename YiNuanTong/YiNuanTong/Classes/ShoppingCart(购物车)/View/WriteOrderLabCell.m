//
//  WriteOrderLabCell.m
//  YiNuanTong
//
//  Created by 纪高飞 on 16/12/27.
//  Copyright © 2016年 纪高飞. All rights reserved.
//

#import "WriteOrderLabCell.h"
#import "YNTUITools.h"
@implementation WriteOrderLabCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if ([super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        // 加载子视图
        [self setUpChildrenViews];
    }
    return self;
}
/**
 *加载子视图
 */
- (void)setUpChildrenViews
{
    // 创建nameLab
    self.nameLab = [YNTUITools createLabel:CGRectMake(33 *kPlus, 20, 70, 16) text:nil textAlignment:NSTextAlignmentLeft textColor:nil bgColor:[UIColor whiteColor]font:16];
    [self.contentView addSubview:self.nameLab];
    
    // 创建副标题
    self.detailNameLab = [YNTUITools createLabel:CGRectMake(KScreenW - 120 - 33 *kPlus, 23, 120, 15) text:nil textAlignment:NSTextAlignmentRight textColor:CGRGray bgColor:[UIColor whiteColor]font:13];
    [self.contentView addSubview:self.detailNameLab];
    
    
    
    
}
@end
