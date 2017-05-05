//
//  WriteOrderRecevieCell.m
//  YiNuanTong
//
//  Created by 纪高飞 on 16/12/27.
//  Copyright © 2016年 纪高飞. All rights reserved.
//

#import "WriteOrderRecevieCell.h"
#import "YNTUITools.h"
@implementation WriteOrderRecevieCell
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
    
    // 创建nameLab
    self.nameLab =[YNTUITools createLabel:CGRectMake(33*kPlus, 51, 40, 13) text:nil textAlignment:NSTextAlignmentLeft textColor:CGRGray bgColor:nil font:26*kPlus];
    [self.contentView addSubview:self.nameLab];
    
    // 创建iphoneLab
    self.phoneLab =[YNTUITools createLabel:CGRectMake(KScreenW - 90-  33*kPlus, 51, 90, 13) text:nil textAlignment:NSTextAlignmentLeft textColor:CGRGray bgColor:nil font:26*kPlus];
   
    [self.contentView addSubview:self.phoneLab];

    // 创建地址lab
    self.addressLab =[YNTUITools createLabel:CGRectMake(33*kPlus, 69, KScreenW - 2 *33 *kPlus, 40) text:nil textAlignment:NSTextAlignmentLeft textColor:CGRGray bgColor:nil font:26*kPlus];
    self.addressLab.numberOfLines = 0;
    [self.contentView addSubview:self.addressLab];

    
                    
}

@end
