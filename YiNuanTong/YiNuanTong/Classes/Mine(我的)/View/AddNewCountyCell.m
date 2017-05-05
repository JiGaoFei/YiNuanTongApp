//
//  AddNewCountyCell.m
//  YiNuanTong
//
//  Created by 纪高飞 on 16/12/26.
//  Copyright © 2016年 纪高飞. All rights reserved.
//

#import "AddNewCountyCell.h"
#import "YNTUITools.h"
@implementation AddNewCountyCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if ([super initWithStyle: style reuseIdentifier:reuseIdentifier]) {
        // 加载子视图
        [self setUpChildrenViews];
    }
    return  self;
}
- (void)setUpChildrenViews
{
    // 创建nameLab
    self.nameLab = [YNTUITools createLabel:CGRectMake(35 *kPlus , 20, 70, 15) text:nil textAlignment:NSTextAlignmentLeft textColor:nil bgColor:[UIColor whiteColor] font:15];
    
    [self.contentView addSubview:self.nameLab];

    // 创建detailNameLab
    self.detailNameLab = [YNTUITools createLabel:CGRectMake(KScreenW - 35 *kPlus-220 , 20, 200, 15) text:nil textAlignment:NSTextAlignmentLeft textColor:nil bgColor:[UIColor whiteColor] font:15];
    
    [self.contentView addSubview:self.detailNameLab];
}
@end
