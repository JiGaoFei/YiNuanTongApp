//
//  WriteOrderTextfileldCell.m
//  YiNuanTong
//
//  Created by 纪高飞 on 16/12/27.
//  Copyright © 2016年 纪高飞. All rights reserved.
//

#import "WriteOrderTextfileldCell.h"
#import "YNTUITools.h"

@interface WriteOrderTextfileldCell ()<UITextFieldDelegate>

@end
@implementation WriteOrderTextfileldCell


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
    self.nameLab = [YNTUITools createLabel:CGRectMake(33 *kPlus, 20, 70, 20) text:nil textAlignment:NSTextAlignmentLeft textColor:nil bgColor:[UIColor whiteColor]font:16];
    [self.contentView addSubview:self.nameLab];
    
    // 创建副标题
    self.textField = [YNTUITools creatTextField:CGRectMake(33 *kPlus +70 +10, 20, KScreenW - 2 * 33*kPlus - 80, 20) bgColor:nil borderStyle:UITextBorderStyleLine placeHolder:@"请输入" keyboardType:UIKeyboardTypeDefault font:13 secureTextEntry:NO clearButtonMode:UITextFieldViewModeAlways];
  
    self.textField.delegate = self;
    [self.contentView addSubview:self.textField];
    
    
    
    
}
#pragma mark - textField代理方法
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

@end
