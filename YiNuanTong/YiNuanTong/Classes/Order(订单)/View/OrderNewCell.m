//
//  OrderNewCell.m
//  YiNuanTong
//
//  Created by 1暖通商城 on 2017/4/11.
//  Copyright © 2017年 纪高飞. All rights reserved.
//

#import "OrderNewCell.h"
#import "YNTUITools.h"
@interface OrderNewCell ()
@property (nonatomic,assign) BOOL isSelect;
@end
@implementation OrderNewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if ([super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.isSelect = YES;
        //  创建视图
        [self setUpChildrenView];
        
    }
    return self;
}
- (void)setUpChildrenView
{
    self.selectBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    self.selectBtn.frame = CGRectMake(15*kWidthScale, 33 *kHeightScale, 18*kWidthScale, 18 *kWidthScale);
    // [self.selectBtn setBackgroundImage:[UIImage imageNamed:@"unchecked@2x"] forState:UIControlStateNormal];
    
    [self.selectBtn addTarget:self action:@selector(selectBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:self.selectBtn];
    
    self.shopNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(43 *kWidthScale, 10 *kHeightScale, 180 *kWidthScale , 60 *kHeightScale)];
    self.shopNameLabel.font = [UIFont systemFontOfSize:11*kHeightScale];
    self.shopNameLabel.numberOfLines = 0;
    self.shopNameLabel.text = @"颜色:亚光粉红;进出口方式:上进下出;口径:4分;中心距:60;术数:30";
    self.shopNameLabel.numberOfLines = 0;
    [self.contentView addSubview:self.shopNameLabel];
    
    self.shopPriceLabel =[[UILabel alloc]initWithFrame:CGRectMake(43 *kWidthScale, 60 *kHeightScale, 200 *kWidthScale , 15 *kHeightScale)];
    self.shopPriceLabel.font = [UIFont systemFontOfSize:12*kHeightScale];
    self.shopPriceLabel.text = @"99.99元/个";
    self.shopPriceLabel.textColor = [UIColor colorWithRed:247.0/255 green:87.0/255 blue:50.0/255 alpha:1.0];
    
    [self.contentView addSubview:self.shopPriceLabel];
    
    
    
    
    // 创建加减背景
    UIImageView *addImgView = [YNTUITools createImageView:CGRectMake(KScreenW - 137*kWidthScale, 30 *kHeightScale, 112*kWidthScale, 24*kHeightScale) bgColor:nil imageName:@"number_frame"];
    addImgView.userInteractionEnabled = YES;
    [self.contentView addSubview:addImgView];
    
    
    //数量加按钮
    UIButton *addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    addBtn.frame = CGRectMake(KScreenW - 47*kWidthScale, 35 *kHeightScale, 22 *kWidthScale,22*kWidthScale);
    
    [addBtn addTarget:self action:@selector(addBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:addBtn];
    // 数量显示
 
    self.numberLab = [YNTUITools createLabel:CGRectMake(KScreenW-118*kWidthScale, 32*kHeightScale, 66*kWidthScale, 22*kHeightScale) text:@"" textAlignment:NSTextAlignmentLeft textColor:nil bgColor:nil font:14*kHeightScale];
       [self.contentView addSubview:_numberLab];
    
    //数量减按钮
    UIButton *cutBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    cutBtn.frame =  CGRectMake(KScreenW - 136*kWidthScale, 35*kHeightScale,22*kWidthScale,22*kHeightScale);
    [cutBtn addTarget:self action:@selector(cutBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView  addSubview:cutBtn];
    
}
#pragma mark - 点击选中按钮事件
- (void)selectBtnAction:(UIButton *)sender
{
    if (self.isSelect) {
        // [sender setBackgroundImage:[UIImage imageNamed:@"unchecked@2x"] forState:UIControlStateNormal];
        self.isSelect  = NO;
        // 取消选中回调事件
        if (self.selectBtnBlock) {
            self.selectBtnBlock(NO);
        }
    }else{
        //  [sender setBackgroundImage:[UIImage imageNamed:@"checked@2x"] forState:UIControlStateNormal];
        self.isSelect  = YES;
        // 选中回调事件
        if (self.selectBtnBlock) {
            self.selectBtnBlock(YES);
        }
        
    }
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}



@end
