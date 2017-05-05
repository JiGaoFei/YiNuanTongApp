//
//  ShopBottomView.m
//  1暖通购物车列表
//
//  Created by 1暖通商城 on 2017/4/5.
//  Copyright © 2017年 纪高飞. All rights reserved.
//

#import "ShopBottomView.h"
// 宏定义当前屏幕的宽度
#define KScreenW [UIScreen mainScreen].bounds.size.width
// 宏定义当前屏幕的高度
#define kScreenH [UIScreen mainScreen].bounds.size.height
// 屏幕宽的比例
#define kWidthScale [UIScreen mainScreen].bounds.size.width / 375
// 屏幕高的比例
#define kHeightScale [UIScreen mainScreen].bounds.size.height / 667


@interface ShopBottomView ()
@property (nonatomic,assign) BOOL isAllSelect;

@end
@implementation ShopBottomView
- (instancetype)initWithFrame:(CGRect)frame
{
    if ([super initWithFrame:frame]) {
        self.isAllSelect = YES;
        // 加载视图
        [self setUpChildrenViews];
    }
    return self;
}
- (void)setUpChildrenViews
{  // 全选按钮
    self.allSelectBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    self.allSelectBtn.frame = CGRectMake(15 *kWidthScale, 17 *kHeightScale, 18 *kWidthScale, 18 *kWidthScale) ;
  [_allSelectBtn setBackgroundImage:[UIImage imageNamed:@"order_unchecked"] forState:UIControlStateNormal];
    [_allSelectBtn addTarget:self action:@selector(allSelectBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.allSelectBtn];
    
    // 全选lab
    UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(43 *kWidthScale, 18 *kHeightScale, 50 *kWidthScale, 20 *kHeightScale)];
    lab.text = @"全选";
    [self addSubview:lab];
    
    // 总计
    self.bottomPriceLab = [[UILabel alloc]initWithFrame:CGRectMake(140 *kWidthScale, 10 *kHeightScale, 150 *kWidthScale, 15 *kHeightScale)];
    self.bottomPriceLab.text = @"总计:9999";
    [self addSubview:self.bottomPriceLab];
    
//    self.allNumberLab = [[UILabel alloc]initWithFrame:CGRectMake(140 *kWidthScale, 30 *kHeightScale, 150 *kWidthScale, 15 *kHeightScale)];
//    self.allNumberLab.text = @"6种999件";
//    self.allNumberLab.textColor = [UIColor grayColor];
//    [self addSubview:self.allNumberLab];
    
    // 结算按钮
    UIButton *goPayBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    goPayBtn.frame = CGRectMake(KScreenW - 92 *kWidthScale, 0, 92 *kWidthScale, 52 *kHeightScale);
    goPayBtn.backgroundColor = [UIColor colorWithRed:52.0/255 green:162.0/255 blue:252.0/255 alpha:1.0];
    [goPayBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [goPayBtn setTitle:@"结算" forState:UIControlStateNormal];
    [goPayBtn addTarget:self action:@selector(goPayBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:goPayBtn];
}
#pragma mark - 全选按钮
- (void)allSelectBtnAction:(UIButton *)sender
{
    if (self.isAllSelect) {
  // [sender setBackgroundImage:[UIImage imageNamed:@"order_unchecked"] forState:UIControlStateNormal];
        self.isAllSelect = NO;
        if (self.allSelectBtnBloock) {
            self.allSelectBtnBloock(0);
        }
    }else{
       // [sender setBackgroundImage:[UIImage imageNamed:@"order_checked"] forState:UIControlStateNormal];
        self.isAllSelect = YES;
        if (self.allSelectBtnBloock) {
            self.allSelectBtnBloock(1);
        }

    }
}
#pragma mark - 结算按钮的点击事件
- (void)goPayBtn:(UIButton *)sender
{
    NSLog(@"我要去结算了");
    if (self.payBtnBlook) {
        self.payBtnBlook();
    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
