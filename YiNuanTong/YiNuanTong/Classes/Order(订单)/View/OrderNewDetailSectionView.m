//
//  OrderNewDetailSectionView.m
//  YiNuanTong
//
//  Created by 1暖通商城 on 2017/4/7.
//  Copyright © 2017年 纪高飞. All rights reserved.
//

#import "OrderNewDetailSectionView.h"
#import "YNTUITools.h"

@interface OrderNewDetailSectionView ()
@property (nonatomic,assign) BOOL selcetBtnIsSelect;
@end
@implementation OrderNewDetailSectionView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // 加载视图
        [self setUpChildrenViews];
        self.selcetBtnIsSelect = NO;
    }
    return self;
}
#pragma mark - 加载视图
- (void)setUpChildrenViews
{
    UILabel *lineLab = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, KScreenW, 2 *kHeightScale)];
    lineLab.backgroundColor = [UIColor grayColor];
    [self addSubview:lineLab];

    
    // 商品图片
    self.goodImgView = [[UIImageView alloc]initWithFrame:CGRectMake(15 *kWidthScale, 20 *kHeightScale, 76*kWidthScale, 76 *kWidthScale)];
    _goodImgView.image = [UIImage imageNamed:@"1"];
    [self addSubview:_goodImgView];
    // 商品 名字
    self.goodNameLab = [YNTUITools createLabel:CGRectMake(128 *kWidthScale, 25 *kHeightScale, 180 *kWidthScale, 40 *kHeightScale) text:@"凯萨散热器钢制散热器凯萨散热器钢制散热器" textAlignment:NSTextAlignmentLeft textColor:nil bgColor:nil font:15 *kHeightScale];
    self.goodNameLab.numberOfLines = 0;
    
    [self addSubview:_goodNameLab];
    
    
    self.roateBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _roateBtn.frame =CGRectMake(KScreenW - 40 *kWidthScale, 48 *kHeightScale, 28 *kWidthScale, 22 *kHeightScale);

    [self.roateBtn addTarget:self action:@selector(roateBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    

   // [self.roateBtn setBackgroundImage:[UIImage imageNamed:@"arrow_after"] forState:UIControlStateNormal];
    [self addSubview:self.roateBtn];
    
}
#pragma mark - 旋转按钮
- (void)roateBtnAction:(UIButton *)sender
{
    sender.selected = !sender.selected;
    
    if (sender.selected) {
        //   NSLog(@"点击的是展开");
        if (self.roateBtnBloock ) {
            self.roateBtnBloock(YES);
          
        }
        
    }else{
        //NSLog(@"点击的是关闭");
        if (self.roateBtnBloock) {
            self.roateBtnBloock(NO);
     
        }
        
        
        
    }
    
    
    
    
}

@end
