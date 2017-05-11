//
//  OrderCollectionViewCell.m
//  多属性角标
//
//  Created by 1暖通商城 on 2017/5/8.
//  Copyright © 2017年 1暖通商城. All rights reserved.
//

#import "OrderCollectionViewCell.h"
@implementation OrderCollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // 创建视图
        [self setUpChildrenViews];
    }
    return self;
}
- (void)setUpChildrenViews
{
    
    self.nameLab = [[UILabel alloc]initWithFrame:CGRectMake(0, 20, 100, 20)];
    self.nameLab.text = @"浅绿";
    self.nameLab.textAlignment = NSTextAlignmentCenter;
    self.nameLab.layer.borderWidth = 1.0;
    self.nameLab.layer.borderColor = [[UIColor grayColor] CGColor];
    self.nameLab.layer.cornerRadius = 5;
    self.nameLab.layer.masksToBounds = YES;
  [self.contentView addSubview:self.nameLab];
    
    self.cornerMarkLab = [[UILabel alloc]initWithFrame:CGRectMake(self.nameLab.frame.origin.x + self.nameLab.frame.size.width - 10, 10, 20, 20)];
    self.cornerMarkLab.layer.cornerRadius = 10;
    self.cornerMarkLab.font = [UIFont systemFontOfSize:13];
    self.cornerMarkLab.layer.masksToBounds = YES;

    self.cornerMarkLab.text = @"";
    self.cornerMarkLab.textColor = [UIColor whiteColor];
    self.cornerMarkLab.backgroundColor = [UIColor redColor];
    [self.contentView addSubview:self.cornerMarkLab];

    
  //  [self.contentView addSubview:self. bagView];
}
- (void)setCellStyle
{
    self.nameLab.backgroundColor = [UIColor blueColor];
}
@end
