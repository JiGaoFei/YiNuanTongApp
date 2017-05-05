//
//  GoodDetailBtnView.m
//  YiNuanTong
//
//  Created by 纪高飞 on 16/12/28.
//  Copyright © 2016年 纪高飞. All rights reserved.
//

#import "GoodDetailBtnView.h"
#import "YNTUITools.h"
@implementation GoodDetailBtnView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // 加载视图
      [self setUpChildrenViews];
        self.productBtn.tag = 2100;
       self.sizeBtn.tag = 2101;
    }
    return self;
}
/**
 *加载视图
 */
- (void)setUpChildrenViews
{
    // 创建产品btn
    self.productBtn = [YNTUITools createButton:CGRectMake(131 *kPlus , 0, 80, 15) bgColor:[UIColor whiteColor] title:@"产品介绍" titleColor:RGBA(50, 163, 251, 1) action:@selector(btnAction:) vc:self];
    [self addSubview:self.productBtn];
    // 创建规格参数btn
    self.sizeBtn = [YNTUITools createButton:CGRectMake(KScreenW - 80 - 131 *kPlus, 0, 80, 15) bgColor:[UIColor whiteColor] title:@"规格参数" titleColor:CGRGray action:@selector(btnAction:) vc:self];
    [self addSubview:self.sizeBtn];
    // 创建线lab
    self.blueLineLab = [YNTUITools createLabel:CGRectMake(131 *kPlus, 17, 80, 2) text:nil textAlignment:NSTextAlignmentLeft textColor:nil bgColor:RGBA(50, 163, 251, 1) font:17];
    [self addSubview:self.blueLineLab];
    
}
#pragma mark - 按钮的点击事件
- (void)btnAction:(UIButton *)sender
{
    NSLog(@"我是按钮的点击事件");
         if (self.btnClicked) {
        self.btnClicked(sender.tag);
    }
}
@end
