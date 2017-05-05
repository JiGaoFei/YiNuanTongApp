//
//  AddressCell.m
//  YiNuanTong
//
//  Created by 纪高飞 on 16/12/26.
//  Copyright © 2016年 纪高飞. All rights reserved.
//

#import "AddressCell.h"
#import "YNTUITools.h"
@implementation AddressCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if ([super initWithStyle: style reuseIdentifier:reuseIdentifier]) {
        // 加载子视图
        [self setUpChidrenViews];
        self.defaultBtn.tag = 1930;
        self.editBtn.tag = 1931;
        self.deleteBtn.tag = 1932;
    }
    return  self;
}
- (void)setUpChidrenViews
{
    // 创建名字
    self.nameLab = [YNTUITools createLabel:CGRectMake(15, 15, 100, 15) text:nil textAlignment:NSTextAlignmentLeft textColor:nil bgColor:[UIColor whiteColor] font:14];
    [self.contentView addSubview:self.nameLab];
    // 创建电话
    self.phoneLab = [YNTUITools createLabel:CGRectMake(KScreenW - 165 , 15, 150, 15) text:nil textAlignment:NSTextAlignmentRight textColor:nil bgColor:[UIColor whiteColor] font:14];
   
    [self.contentView addSubview:self.phoneLab];
  
    // 创建地址
    self.addressLab= [YNTUITools createLabel:CGRectMake(15, CGRectGetMaxY(self.nameLab.frame), KScreenW - 30, 45) text:nil textAlignment:NSTextAlignmentLeft textColor:nil bgColor:[UIColor whiteColor] font:14];
    self.addressLab.numberOfLines = 0;
    [self.contentView addSubview:self.addressLab];
    // 创建线
    UILabel *linLab =[[UILabel alloc]initWithFrame:CGRectMake(15, CGRectGetMaxY(self.addressLab.frame) + 10, KScreenW - 30, 2)];
    linLab.backgroundColor = [UIColor grayColor];
    [self.contentView addSubview:linLab];
    
    
    // 创建编辑按钮
    self.defaultBtn = [YNTUITools createButton:CGRectMake(18.5, CGRectGetMaxY(linLab.frame) +10, 120, 20) bgColor:nil title:@"默认地址" titleColor:CGRBlue action:@selector(btnAction:) vc:self];
    UIImage *defaultBtnImg = [UIImage imageNamed:@"未勾选状态"];
    defaultBtnImg= [defaultBtnImg imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    [self.defaultBtn setImage:defaultBtnImg forState:UIControlStateNormal];
    self.defaultBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 20);
    [self.contentView addSubview:self.defaultBtn];

   
    
    // 创建编辑按钮
    self.editBtn = [YNTUITools createButton:CGRectMake(KScreenW-18.5 - 52 * 3 + 35 , CGRectGetMaxY(linLab.frame) +10,52, 18.5) bgColor:nil title:@"编辑" titleColor:CGRGray action:@selector(btnAction:) vc:self];
    UIImage *editBtnImg = [UIImage imageNamed:@"编辑图标"];
    editBtnImg = [editBtnImg imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    [self.editBtn setImage:editBtnImg forState:UIControlStateNormal];
    self.editBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 20);
    [self.contentView addSubview:self.editBtn];
    // 创建删除按钮
    self.deleteBtn = [YNTUITools createButton:CGRectMake(KScreenW-18.5 - 52, CGRectGetMaxY(linLab.frame) +10,52, 18) bgColor:nil title:@"删除" titleColor:CGRGray action:@selector(btnAction:) vc:self];
    
    UIImage *deleteBtnImg = [UIImage imageNamed:@"删除图标"];
    deleteBtnImg = [deleteBtnImg imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [self.deleteBtn setImage:deleteBtnImg forState:UIControlStateNormal];
    self.deleteBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 20);
    
    [self.contentView addSubview:self.deleteBtn];
    

    
}
- (void)btnAction:(UIButton *)sender
{
    NSLog(@"我是被点击了") ;
    if (self.buttonClicked) {
        
        self.buttonClicked(sender.tag);
        
    }


}
@end
