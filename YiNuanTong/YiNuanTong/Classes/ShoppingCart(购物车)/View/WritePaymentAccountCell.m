//
//  WritePaymentAccountCell.m
//  YiNuanTong
//
//  Created by 纪高飞 on 16/12/27.
//  Copyright © 2016年 纪高飞. All rights reserved.
//

#import "WritePaymentAccountCell.h"
#import "YNTUITools.h"
@implementation WritePaymentAccountCell
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
    // 创建titleLab
    self.titleLab =[YNTUITools createLabel:CGRectMake(33 *kPlus, 20, 70, 16) text:nil textAlignment:NSTextAlignmentLeft textColor:nil bgColor:[UIColor whiteColor]font:16];
    [self.contentView addSubview:self.titleLab];
    
    // 创建账户Lab
    self.bankNameLab =[YNTUITools createLabel:CGRectMake(33*kPlus, 51, KScreenW - 2 *33 *kPlus, 13) text:nil textAlignment:NSTextAlignmentLeft textColor:CGRGray bgColor:nil font:26*kPlus];
    [self.contentView addSubview:self.bankNameLab];
    
    
    // 创建账户名称lab
    self.accountLab =[YNTUITools createLabel:CGRectMake(33*kPlus, 69, KScreenW - 2 *33 *kPlus, 13) text:nil textAlignment:NSTextAlignmentLeft textColor:CGRGray bgColor:nil font:26*kPlus];
    [self.contentView addSubview:self.accountLab];
    
    // 创建开户账号Lab
    self.accountNumLab =[YNTUITools createLabel:CGRectMake(33*kPlus, 87, KScreenW - 2 *33 *kPlus, 13) text:nil textAlignment:NSTextAlignmentLeft textColor:CGRGray bgColor:nil font:26*kPlus];
    [self.contentView addSubview:self.accountNumLab];

    
    
    
}

@end
