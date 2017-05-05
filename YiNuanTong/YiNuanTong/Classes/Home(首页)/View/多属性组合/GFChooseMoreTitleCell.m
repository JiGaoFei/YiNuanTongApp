//
//  GFChooseMoreTitleCell.m
//  YiNuanTong
//
//  Created by 1暖通商城 on 2017/4/22.
//  Copyright © 2017年 纪高飞. All rights reserved.
//

#import "GFChooseMoreTitleCell.h"
#import "YNTUITools.h"
#import "GFBageLable.h"
#import "HomeShopListSizeModel.h"
@implementation GFChooseMoreTitleCell
 - (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if ([super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        // 加载视图
        [self setUpChildrenViews];
    }
    return self;
}

//加载视图
- (void)setUpChildrenViews
{
    self.nameLab= [[GFBageLable alloc]initWithFrame:CGRectMake(-15*kWidthScale, 30,80 *kHeightScale,20 *kWidthScale)];
    self.nameLab.layer.borderColor =[RGBA(220, 220, 220, 1) CGColor];
    self.nameLab.layer.cornerRadius = 5;
    self.nameLab.layer.masksToBounds = YES;
   self.nameLab.font = [UIFont systemFontOfSize:15*kHeightScale];
    self.nameLab.layer.borderWidth = 1;
    self.nameLab.text = @"上进下出";
     self.nameLab.textAlignment = NSTextAlignmentCenter;
     self.nameLab.transform = CGAffineTransformMakeRotation(M_PI / 2);

    [self.contentView addSubview:self.nameLab];
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)setValueWithModel:(HomeShopListSizeModel *)model
{
   CGFloat w=  [self widthForLabel:model.name fontSize:15 *kHeightScale ];
    CGRect rec = self.nameLab.frame;
    rec.size.height = w + 10;
    self.nameLab.frame = rec;
}
/**
 *  计算文字长度
 */
- (CGFloat)widthForLabel:(NSString *)text fontSize:(CGFloat)font
{
    CGSize size = [text sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:font], NSFontAttributeName, nil]];
    return size.width;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
