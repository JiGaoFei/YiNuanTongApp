//
//  LogoutCell.m
//  YiNuanTong
//
//  Created by 纪高飞 on 16/12/22.
//  Copyright © 2016年 纪高飞. All rights reserved.
//

#import "LogoutCell.h"
#import "YNTUITools.h"
@implementation LogoutCell
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // 加载视图
        [self setUpChildrenViews];
        self.logoutBtn.tag = 1910;
    }
    return self;
}
/**
 *加载视图
 */
- (void)setUpChildrenViews
{
    self.logoutBtn =[YNTUITools createButton:CGRectMake(0, 10, KScreenW, 40) bgColor:RGBA(250, 85, 87, 1) title:@"退出" titleColor:[UIColor whiteColor] action:@selector(logoutBtnAction:) vc:self];
    [self.contentView addSubview:self.logoutBtn];
}
- (void)logoutBtnAction:(UIButton *)sender
{
    if (self.buttonClicked) {
        self.buttonClicked(sender.tag);
    }
    NSLog(@"退出按钮点击事件");
    
}
@end
