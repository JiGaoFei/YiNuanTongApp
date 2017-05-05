//
//  AddressSwitchCell.m
//  YiNuanTong
//
//  Created by 纪高飞 on 16/12/26.
//  Copyright © 2016年 纪高飞. All rights reserved.
//

#import "AddressSwitchCell.h"
#import "YNTUITools.h"
@implementation AddressSwitchCell
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
- (void) setUpChildrenViews
{
    // 创建nameLab
    self.nameLab = [YNTUITools createLabel:CGRectMake(35 *kPlus , 20, 110, 15) text:nil textAlignment:NSTextAlignmentLeft textColor:nil bgColor:[UIColor whiteColor] font:15];
    
    [self.contentView addSubview:self.nameLab];
    // 创建开关
    self.swithBtn = [[UISwitch alloc]initWithFrame:CGRectMake(KScreenW - 60, 12, 45, 15)];
    self.swithBtn.onTintColor  = CGRBlue;
    [self.swithBtn setOn:NO];
    // 设置开关按钮的比例
    self.swithBtn.transform = CGAffineTransformMakeScale(kWidthScale *0.9, kHeightScale*0.9);
    [self.contentView addSubview:self.swithBtn];
     [self.swithBtn addTarget:self action:@selector(switchAction:) forControlEvents:UIControlEventValueChanged];

}
- (void)switchAction:(UISwitch *)sender
{
    NSLog(@"我是开关按钮");
    UISwitch *switchButton = (UISwitch*)sender;
    BOOL isButtonOn = [switchButton isOn];
    if (self.swithBtn) {
        
        if (!isButtonOn) {
            self.swichBtnClick(1940);
            
        }else{
            self.swichBtnClick(1941);
        }
        
    }
}

@end
