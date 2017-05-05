//
//  MinFourBtnCell.m
//  YiNuanTong
//
//  Created by 纪高飞 on 16/12/16.
//  Copyright © 2016年 纪高飞. All rights reserved.
//

#import "MinFourBtnCell.h"
#import "YNTUITools.h"
@implementation MinFourBtnCell
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUpChildrenViews];
        self.noPayBtn.tag = 1510;
        self.noSendBtn.tag =1511;
        self.noAcceptBtn.tag =1512;
        self.comepleteBtn.tag = 1513;
    }
    return self;
}
// 创建子视图
- (void)setUpChildrenViews
{   CGFloat coloumSpacing =( KScreenW  -60*4) /5;
    
    // 创建待付款btn
    self.noPayBtn = [YNTUITools createButton:CGRectMake(coloumSpacing, 0, 60, 80) bgColor:nil title:@"待付款" titleColor:nil action:@selector(btnAction:) vc:self];
    // 设置图片和文字的位置
    [self.noPayBtn setImage:[UIImage imageNamed:@"注册"] forState:UIControlStateNormal];
    self.noPayBtn.titleEdgeInsets =UIEdgeInsetsMake(-40, self.noPayBtn.titleLabel.bounds.size.width-50, 0, 0);
    
    // 创建待发货btn
    self.noSendBtn = [YNTUITools createButton:CGRectMake(coloumSpacing *2 +60, 0, 60, 80) bgColor:nil title:@"待发货" titleColor:nil action:@selector(btnAction:) vc:self];
    // 设置图片和文字的位置
    [self.noSendBtn  setImage:[UIImage imageNamed:@"注册"] forState:UIControlStateNormal];
    self.noSendBtn.titleEdgeInsets =UIEdgeInsetsMake(-40, self.noSendBtn.titleLabel.bounds.size.width-50, 0, 0);


    // 创建待收货btn
    self.noAcceptBtn = [YNTUITools createButton:CGRectMake(coloumSpacing *3+120, 0, 60, 80) bgColor:nil title:@"待收货" titleColor:nil action:@selector(btnAction:) vc:self];
    // 设置图片和文字的位置
    [self.noAcceptBtn setImage:[UIImage imageNamed:@"注册"] forState:UIControlStateNormal];
    self.noAcceptBtn.titleEdgeInsets =UIEdgeInsetsMake(-40, self.noAcceptBtn.titleLabel.bounds.size.width-50, 0, 0);


    // 创建已完成btn
    self.comepleteBtn = [YNTUITools createButton:CGRectMake(coloumSpacing *4+180, 0, 60, 80) bgColor:nil title:@"已完成" titleColor:nil action:@selector(btnAction:) vc:self];
    // 设置图片和文字的位置
    [self.comepleteBtn setImage:[UIImage imageNamed:@"注册"] forState:UIControlStateNormal];
    self.comepleteBtn.titleEdgeInsets =UIEdgeInsetsMake(-40, self.comepleteBtn.titleLabel.bounds.size.width-50, 0, 0);

    [self.contentView addSubview:self.noPayBtn];
    [self.contentView addSubview:self.noSendBtn];
    [self.contentView addSubview:self.noAcceptBtn];
    [self.contentView addSubview:self.comepleteBtn];

    
    
}
// btn的点击方法
- (void)btnAction:(UIButton *)sender
{
  
    self.buttonClicked(sender.tag);
}
@end
