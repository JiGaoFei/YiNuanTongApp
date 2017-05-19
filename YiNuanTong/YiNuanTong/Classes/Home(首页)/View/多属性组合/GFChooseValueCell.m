//
//  GFChooseValueCell.m
//  YiNuanTong
//
//  Created by 纪高飞 on 17/5/19.
//  Copyright © 2017年 纪高飞. All rights reserved.
//

#import "GFChooseValueCell.h"
#import "YNTUITools.h"
#import "GFBageLable.h"
#import "HomeShopListSizeModel.h"
@implementation GFChooseValueCell

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
    
    
    ///设置角标
    self.cornerMarkLB = [[GFBageLable alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.nameLab.frame)  - 10 , CGRectGetMinY(self.nameLab.frame) + 30 *kWidthScale , (40 *kWidthScale)/2, (40 *kWidthScale)/2)];
    self.cornerMarkLB.backgroundColor =[UIColor redColor];
    self.cornerMarkLB.layer.cornerRadius = (40 *kWidthScale)/ 4;
    self.cornerMarkLB.layer.borderWidth = 1;
    self.cornerMarkLB.layer.masksToBounds = YES;
    self.cornerMarkLB.layer.borderColor = [[UIColor redColor] CGColor];
    self.cornerMarkLB.text = @"0";
    self.cornerMarkLB.textColor = [UIColor whiteColor];
    //    self.cornerMarkLB.hidden = YES;
    self.cornerMarkLB.textAlignment = NSTextAlignmentCenter;
    self.cornerMarkLB.transform = CGAffineTransformMakeRotation(M_PI / 2);
    self.cornerMarkLB.font=[UIFont systemFontOfSize:12];
    [self.contentView addSubview:self.cornerMarkLB];
    
    [self.contentView bringSubviewToFront:self.cornerMarkLB];
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
