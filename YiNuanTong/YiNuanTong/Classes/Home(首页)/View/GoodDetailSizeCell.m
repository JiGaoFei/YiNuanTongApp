//
//  GoodDetailSizeCell.m
//  YiNuanTong
//
//  Created by 1暖通商城 on 2017/4/19.
//  Copyright © 2017年 纪高飞. All rights reserved.
//

#import "GoodDetailSizeCell.h"
#import "YNTUITools.h"
@implementation GoodDetailSizeCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if ([super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        // 加载视图
        [self setUpChildrenViews];
    }
    return self;
}
// 加载视图
- (void)setUpChildrenViews
{
    UILabel *sizeLab = [YNTUITools createLabel:CGRectMake(15 *kWidthScale, 15 *kHeightScale, 80 *kWidthScale, 15 *kHeightScale) text:@"规格选择" textAlignment:NSTextAlignmentLeft textColor:nil bgColor:nil font:15 *kHeightScale];
    UIImageView *imgView = [YNTUITools createImageView:CGRectMake(110 *kWidthScale, 15 *kHeightScale, 6 *kWidthScale, 12 *kHeightScale) bgColor:nil imageName:@"箭头"];
    [self.contentView addSubview:imgView];
    UILabel *lineLab = [[UILabel alloc]initWithFrame:CGRectMake(0, 45 *kHeightScale, KScreenW, 10*kHeightScale)];
    lineLab.backgroundColor = RGBA(245, 246, 247, 1);
    
    [self.contentView addSubview:lineLab];
    
    [self.contentView addSubview:sizeLab];
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
