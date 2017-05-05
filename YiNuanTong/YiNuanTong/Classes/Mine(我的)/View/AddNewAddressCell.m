//
//  AddNewAddressCell.m
//  YiNuanTong
//
//  Created by 纪高飞 on 16/12/26.
//  Copyright © 2016年 纪高飞. All rights reserved.
//

#import "AddNewAddressCell.h"
#import "YNTUITools.h"

@interface AddNewAddressCell ()<UITextFieldDelegate>

@end
@implementation AddNewAddressCell

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
    self.nameLab = [YNTUITools createLabel:CGRectMake(35 *kPlus *kWidthScale , 20 *kHeightScale, 70 *kWidthScale, 15 *kHeightScale) text:nil textAlignment:NSTextAlignmentLeft textColor:nil bgColor:[UIColor whiteColor] font:15];
    if (KScreenW == 320) {
        self.nameLab.font = [UIFont systemFontOfSize:13];
    }
    
    [self.contentView addSubview:self.nameLab];
    
    // 创建textField
    self.textField = [YNTUITools creatTextField:CGRectMake(35*kPlus+120, 20, KScreenW - 2*35*kPlus - 90-40, 15) bgColor:[UIColor whiteColor] borderStyle:UITextBorderStyleNone placeHolder:nil keyboardType:UIKeyboardTypeDefault font:13 secureTextEntry:NO clearButtonMode:UITextFieldViewModeAlways];
    self.textField.delegate = self;
    [self.contentView addSubview:self.textField];
}

#pragma mark - tableView的代理方法

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
@end
