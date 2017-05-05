//
//  GFDropDownMenu.m
//  YiNuanTong
//
//  Created by 纪高飞 on 16/12/19.
//  Copyright © 2016年 纪高飞. All rights reserved.
//

#import "GFDropDownMenu.h"
#import "YNTUITools.h"


@interface GFDropDownMenu ()

@end
@implementation GFDropDownMenu
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.oneBtn.tag = 1600;
        self.twoBtn.tag = 1601;
        self.threeBtn.tag = 1602;
        self.fourBtn.tag = 1603;
        // 加载视图
        [self setUpChildrenViews];
    
    }
    return self;
}
/**
 *加载子视图
 */

- (void)setUpChildrenViews
{
    //创建数组
    NSArray *arr = @[@"品牌",@"价格",@"更多",@"筛选"].mutableCopy;
//    self.oneBtn =  [YNTUITools createButton:CGRectMake(0 *KScreenW/4, 0, KScreenW/4, 44) bgColor:[UIColor whiteColor] title:arr[0] titleColor:RGBA(64, 157, 235, 1) action:@selector(btnAction:) vc:self];
//    [self addSubview:self.oneBtn];
//    
//    
//    self.twoBtn =  [YNTUITools createButton:CGRectMake(1 *KScreenW/4, 0, KScreenW/4, 44) bgColor:[UIColor whiteColor] title:arr[1] titleColor:RGBA(64, 157, 235, 1) action:@selector(btnAction:) vc:self];
//    [self addSubview:self.twoBtn];
//    
//    self.threeBtn =  [YNTUITools createButton:CGRectMake(2 *KScreenW/4, 0, KScreenW/4, 44) bgColor:[UIColor whiteColor] title:arr[2] titleColor:RGBA(64, 157, 235, 1) action:@selector(btnAction:) vc:self];
//    [self addSubview:self.threeBtn];
//    
//    self.fourBtn =  [YNTUITools createButton:CGRectMake(3 *KScreenW/4, 0, KScreenW/4, 44) bgColor:[UIColor whiteColor] title:arr[3] titleColor:RGBA(64, 157, 235, 1) action:@selector(btnAction:) vc:self];
//    [self addSubview:self.fourBtn];
//
   
    for (int i = 0; i <arr.count; i++) {
        UIButton *btn = [YNTUITools createButton:CGRectMake(i *KScreenW/4, 0, KScreenW/4, 44) bgColor:[UIColor whiteColor] title:arr[i] titleColor:RGBA(64, 157, 235, 1) action:@selector(btnAction:) vc:self];
        
        if (i !=1) {
            UIImage *img = [UIImage imageNamed:@"箭头向下"];
            img = [img imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
            [btn setImage:img forState:UIControlStateNormal];
            btn.imageEdgeInsets = UIEdgeInsetsMake(0, 70, 0, 0) ;
        }else{
            UIImage *img = [UIImage imageNamed:@"双箭头下"];
            img = [img imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
            [btn setImage:img forState:UIControlStateNormal];
            btn.imageEdgeInsets = UIEdgeInsetsMake(0, 70, 0, 0) ;
            
        }
        btn.tag = 1600+i;
        [self addSubview:btn];
    }

    self.oneBtn = [self viewWithTag:1600];
    self.twoBtn =  [self viewWithTag:1601];
    self.threeBtn =  [self viewWithTag:1602];
    self.fourBtn =  [self viewWithTag:1603];
    
    
}
- (void)btnAction:(UIButton *)sender
{
    NSLog(@"'我是筛选框的点击");
    if (self.bttonClicked) {
        self.bttonClicked(sender.tag);
       
    }
   
}
@end
