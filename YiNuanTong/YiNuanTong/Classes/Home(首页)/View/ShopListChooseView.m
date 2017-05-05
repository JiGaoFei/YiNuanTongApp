//
//  ShopListChooseView.m
//  YiNuanTong
//
//  Created by 纪高飞 on 16/12/20.
//  Copyright © 2016年 纪高飞. All rights reserved.
//

#import "ShopListChooseView.h"
#import "YNTUITools.h"
@implementation ShopListChooseView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
            [self setUpChildrenViews];
        self.maxToMinBtn.tag = 1700;
        self.minToMaxBtn.tag = 1701;
        self.resetBtn.tag = 1702;
        self.completeBtn.tag = 1703;

    }
    return self;
}
/**
 *创建子视图
 */
- (void)setUpChildrenViews
{
    // 价格区间lab
    UILabel *priceRangeLab = [YNTUITools createLabel:CGRectMake(20 *kWidthScale, 20 *kHeightScale,120 *kWidthScale, 20 *kHeightScale) text:@"价格区间(元)" textAlignment:NSTextAlignmentLeft textColor:[UIColor blackColor] bgColor:[UIColor whiteColor] font:17];
    if (KScreenW == 320) {
        priceRangeLab.font = [UIFont systemFontOfSize:15];
    }
    [self addSubview:priceRangeLab];
    
    
    UIView *bakgroundView = [[UIView alloc]initWithFrame:CGRectMake(20 *kWidthScale, 45 *kHeightScale, KScreenW - 40 *kWidthScale, 30 *kHeightScale)];
    
    bakgroundView.backgroundColor = RGBA(215, 215, 215, 1);
    [self addSubview:bakgroundView];
    
    // 最低价
    self.minTextField = [YNTUITools creatTextField:CGRectMake(10 *kWidthScale, 3 *kHeightScale, 80 *kWidthScale, 24 *kHeightScale) bgColor:[UIColor whiteColor] borderStyle:UITextBorderStyleRoundedRect placeHolder:@"最低价" keyboardType:UIKeyboardTypeNumbersAndPunctuation font:17 secureTextEntry:NO clearButtonMode:UITextFieldViewModeAlways];
    if (KScreenW == 320) {
        _minTextField.font = [UIFont systemFontOfSize:15];
    }
    
    [bakgroundView addSubview:_minTextField];
    
    UILabel *lineLab = [YNTUITools createLabel:CGRectMake(KScreenW/2-2.5, 14 *kHeightScale,5 *kWidthScale, 2 *kHeightScale) text:nil textAlignment:NSTextAlignmentLeft textColor:[UIColor blackColor] bgColor:[UIColor blackColor] font:17];
    [bakgroundView addSubview:lineLab];

    // 最高价
   self.maxTextField = [YNTUITools creatTextField:CGRectMake(KScreenW - (40 + 90) *kWidthScale, 3 *kHeightScale, 80 *kWidthScale, 24 *kHeightScale) bgColor:[UIColor whiteColor] borderStyle:UITextBorderStyleRoundedRect placeHolder:@"最高价" keyboardType:UIKeyboardTypeNumbersAndPunctuation font:17 secureTextEntry:NO clearButtonMode:UITextFieldViewModeAlways];
    if (KScreenW == 320) {
        _maxTextField.font = [UIFont systemFontOfSize:15];
    }
    
    
      [bakgroundView addSubview:_maxTextField];

      // 销量btn
    UILabel *saleNumberLab = [YNTUITools createLabel:CGRectMake(20 *kWidthScale, 80 *kHeightScale, 60 *kWidthScale, 20 *kHeightScale) text:@"销量:"  textAlignment:NSTextAlignmentCenter textColor:CGRBlue bgColor:[UIColor whiteColor] font:17];
    if (KScreenW == 320) {
        saleNumberLab.font = [UIFont systemFontOfSize:15];
    }
    [self addSubview:saleNumberLab];
  
    
    self.maxToMinBtn = [YNTUITools createButton:CGRectMake(85 *kWidthScale, 80 *kHeightScale, 80 *kWidthScale, 20 *kHeightScale) bgColor:[UIColor whiteColor] title:@"从高到低" titleColor:CGRBlue action:@selector(btnAction:) vc:self];
    [self addSubview:self.maxToMinBtn];
    
    
    self.minToMaxBtn = [YNTUITools createButton:CGRectMake(85 *kWidthScale, 110 *kHeightScale, 80 *kWidthScale, 20*kHeightScale) bgColor:[UIColor whiteColor] title:@"从低到高" titleColor:nil action:@selector(btnAction:) vc:self];
    [self addSubview:self.minToMaxBtn];

    
 
    
    self.resetBtn = [YNTUITools createButton:CGRectMake(0, 150 *kHeightScale, KScreenW/2, 50*kHeightScale) bgColor:[UIColor whiteColor] title:@"重置" titleColor:nil action:@selector(btnAction:) vc:self];
    [self addSubview:self.resetBtn];
    
    self.completeBtn = [YNTUITools createButton:CGRectMake(KScreenW / 2, 150 *kHeightScale, KScreenW/2, 50 *kHeightScale) bgColor:CGRBlue title:@"完成" titleColor:[UIColor whiteColor] action:@selector(btnAction:) vc:self];
    [self addSubview:self.completeBtn];
    
    
    }
/**
 *按钮的点击事件

 */
- (void)btnAction:(UIButton *)sender
{
    NSLog(@"我是怎么了");
    if (self.btnClicked) {
        self.btnClicked(sender.tag);
    }
}

@end
