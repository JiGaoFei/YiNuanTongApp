//
//  ShopThreeCooperationView.m
//  YiNuanTong
//
//  Created by 纪高飞 on 16/12/19.
//  Copyright © 2016年 纪高飞. All rights reserved.
//

#import "ShopThreeCooperationView.h"
#import "YNTUITools.h"
@implementation ShopThreeCooperationView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //加载视图
        [self setUpChildrenViews];
    }
    return self;
}
/**
 *创建视图
 */
- (void)setUpChildrenViews
{
    // 创建lineLab
    UILabel *lineLeftLab = [YNTUITools createLabel:CGRectMake(20*kWidthScale, 9*kHeightScale, (KScreenW - 180*kWidthScale) / 2, 1) text:nil textAlignment:NSTextAlignmentCenter textColor:nil bgColor:[UIColor grayColor] font:17];
    [self addSubview:lineLeftLab];
    
    
    // 创建中间contentLab
    self.titileNameLab = [YNTUITools createLabel:CGRectMake(KScreenW/2-70*kWidthScale, 0, 140*kWidthScale, 20*kHeightScale) text:nil textAlignment:NSTextAlignmentCenter textColor:nil bgColor:nil font:17];
    [self addSubview:self.titileNameLab];
    if (KScreenW == 320 ) {
        self.titileNameLab.font = [UIFont systemFontOfSize:15];
    }
    
    
    UILabel *lineRightLab = [YNTUITools createLabel:CGRectMake(70*kWidthScale +KScreenW/2, 9*kHeightScale, (KScreenW - 180*kWidthScale) / 2, 1) text:nil textAlignment:NSTextAlignmentCenter textColor:nil bgColor:[UIColor grayColor] font:17];
    [self addSubview:lineRightLab];
}

@end
