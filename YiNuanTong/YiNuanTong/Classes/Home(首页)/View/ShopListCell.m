//
//  ShopListCell.m
//  YiNuanTong
//
//  Created by 纪高飞 on 16/12/20.
//  Copyright © 2016年 纪高飞. All rights reserved.
//

#import "ShopListCell.h"
#import "YNTUITools.h"
#import "UIImageView+WebCache.h"
#import "HomeShopListModel.h"
@implementation ShopListCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if ([super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setUpChildrenViews];
        self.listCarBtn.tag = 1720;
    }
    return self;
}

/**
 *创建子视图
 */
- (void) setUpChildrenViews
{
    // 创建商品图片
    self.listImageView = [YNTUITools createImageView:CGRectMake(6 *kWidthScale, 10 *kHeightScale, 108 *kWidthScale, 108 *kHeightScale) bgColor:nil imageName:@"女1"];
    self.listImageView.userInteractionEnabled = YES;
    [self addSubview:self.listImageView];
    
   self.newlab=  [[UILabel alloc]initWithFrame:CGRectMake(100*kWidthScale, 5 *kHeightScale, 24 *kWidthScale, 24 *kWidthScale)];
    self.newlab.text = @"新";
    self.newlab.font = [UIFont systemFontOfSize:8];
    self.newlab.textColor = [UIColor redColor];
    self.newlab.backgroundColor = RGBA(255, 0, 0, 1);
    self.newlab.layer.cornerRadius = 12 *kWidthScale;
    self.newlab.layer.masksToBounds = YES;
    self.newlab.textAlignment = NSTextAlignmentCenter;
     [self.contentView addSubview:self.newlab];
    [self.contentView bringSubviewToFront:self.newlab];
   
    // 创建商品名
    self.listNameLabel = [YNTUITools createLabel:CGRectMake(135 *kWidthScale, 15 *kHeightScale, KScreenW - 145 *kWidthScale, 40 *kHeightScale) text:@"" textAlignment:NSTextAlignmentLeft textColor:nil bgColor:nil font:15 *kHeightScale];
    self.listNameLabel.numberOfLines = 0;
    
    [self addSubview:self.listNameLabel];
    // 创建规格
    self.listSizeLabel = [YNTUITools createLabel:CGRectMake(135 *kWidthScale, 72 *kHeightScale, 200 *kWidthScale, 12 *kHeightScale) text:@"" textAlignment:NSTextAlignmentLeft textColor:nil bgColor:nil font:12];
    [self addSubview:self.listSizeLabel];
    // 创建价格
    self.listPriceLabel = [YNTUITools createLabel:CGRectMake(130 *kWidthScale, 100 *kHeightScale, 200 *kWidthScale, 15 *kHeightScale) text:@"" textAlignment:NSTextAlignmentLeft textColor:[UIColor redColor] bgColor:nil font:15 *kHeightScale];
    [self addSubview:self.listPriceLabel];
    // 创建购物车按钮
    self.listCarBtn = [YNTUITools createButton:CGRectMake(KScreenW - 48*kWidthScale, 75 *kHeightScale, 33 *kWidthScale, 33 *kWidthScale) bgColor:nil title:nil titleColor:nil action:@selector(listCarBtnAction:) vc:self];
    UIImage *img = [UIImage imageNamed:@"常规状态的购物车"];
    img = [img imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [self.listCarBtn setImage:img  forState:UIControlStateNormal];
 //   [self addSubview:self.self.listCarBtn];
    

    
    
}
- (void)setValueWithMode:(HomeShopListModel*)model
{
    NSURL *url = [NSURL URLWithString:model.cover_img];
    [self.listImageView sd_setImageWithURL:url];
    self.listNameLabel.text = model.name;
    //self.listSizeLabel.text =[NSString stringWithFormat:@"%ld个规格可选",(long)model.sizecount];
    self.listPriceLabel.text = [NSString stringWithFormat:@"￥ %@",model.price];
}
/**
 *购物车按钮点击事件
 */
- (void)listCarBtnAction:(UIButton *)sender
{
    NSLog(@"点击的是购物车list按钮");
    if (self.carBtnClicked) {
        self.carBtnClicked(sender.tag);
    }
}
@end
