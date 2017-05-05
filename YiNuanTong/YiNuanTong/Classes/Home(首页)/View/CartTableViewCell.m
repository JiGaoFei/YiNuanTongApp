//
//  CartTableViewCell.m
//  ArtronUp
//
//  Created by Artron_LQQ on 15/12/1.
//  Copyright © 2015年 ArtronImages. All rights reserved.
//

#import "CartTableViewCell.h"
#import "YNTUITools.h"
#import "HomeGoodsModel.h"
#import "UIImageView+WebCache.h"
@interface CartTableViewCell ()
@end

@implementation CartTableViewCell


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

 
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
       
        [self setupMainView];
    }
    return self;
}
//选中按钮点击事件
-(void)selectBtnClick:(UIButton*)button
{
    button.selected = !button.selected;
    if (self.cartBlock) {
        self.cartBlock(button.selected);
    }
}

-(void)reloadDataWith:(HomeGoodsModel*)model
{
    [self.shopImageView sd_setImageWithURL:[NSURL URLWithString:model.cover_img]];
    self.nameLabel.text = model.name;
    self.priceLabel.text = model.price;
    self.shopNumberLabel.text = [NSString stringWithFormat:@"%ld个规格",(long)model.sizecount] ;
    self.selectBtn.selected = self.isSelected;

}
-(void)setupMainView
{
    
    //选中按钮
    self.selectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.selectBtn.selected = self.isSelected;
     self.selectBtn.frame = CGRectMake(15 *kWidthScale, 55 *kHeightScale, 20 *kWidthScale, 20 *kWidthScale);
    [self.selectBtn setImage:[UIImage imageNamed:@"order_unchecked"] forState:UIControlStateNormal];
    [self.selectBtn setImage:[UIImage imageNamed:@"order_checked"] forState:UIControlStateSelected];
    [self.selectBtn addTarget:self action:@selector(selectBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:self.selectBtn];
    self.shopImageView = [YNTUITools createImageView:CGRectMake(77 *kPlus *kWidthScale, 20 *kHeightScale, 220 *kPlus *kWidthScale , 209 *kPlus *kHeightScale) bgColor:nil imageName:@"女1"];
    [self.contentView  addSubview:self.shopImageView];
    // 创建产品lab
    self.nameLabel = [YNTUITools createLabel:CGRectMake(170 *kWidthScale, 20 *kHeightScale, 200 *kWidthScale, 40 *kHeightScale) text:@"凯萨-PPR-φ25  等径三通" textAlignment:NSTextAlignmentLeft textColor:nil bgColor:nil font:16 *kHeightScale];
    self.nameLabel.numberOfLines = 0;
    [self.contentView addSubview:self.nameLabel];
    // 创建编号lab
    self.shopNumberLabel = [YNTUITools createLabel:CGRectMake(170 *kWidthScale, 70 *kHeightScale, 200 *kWidthScale, 12 *kHeightScale) text:@"1个规格" textAlignment:NSTextAlignmentLeft textColor:CGRGray bgColor:nil font:12 *kHeightScale];
    [self.contentView addSubview:self.shopNumberLabel];
    
    
       // 创建价格lab
    self.priceLabel= [YNTUITools createLabel:CGRectMake(170 *kWidthScale, 90 *kHeightScale, 200 *kWidthScale, 16 *kHeightScale) text:@"100" textAlignment:NSTextAlignmentLeft textColor:CGRRed bgColor:nil font:16 *kHeightScale];
    [self.contentView addSubview:self.priceLabel];
    
    self.listCarBtn = [YNTUITools createButton:CGRectMake(KScreenW - 48 *kWidthScale, 80 *kHeightScale, 33 *kWidthScale, 33 *kWidthScale) bgColor:nil title:nil titleColor:nil action:@selector(listCarBtnClick:) vc:self];
    UIImage *img = [UIImage imageNamed:@"常规状态的购物车"];
    img = [img imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [self.listCarBtn setImage:img  forState:UIControlStateNormal];
    [self.contentView addSubview:self.self.listCarBtn];

     }

#pragma mark - 购物车的点击事件
- (void)listCarBtnClick:(UIButton *)sender
{
    if (self.addCarBlock) {
        self.addCarBlock();
    }
}
@end
