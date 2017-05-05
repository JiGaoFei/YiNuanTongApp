//
//  CommentProblemCell.m
//  YiNuanTong
//
//  Created by 纪高飞 on 16/12/26.
//  Copyright © 2016年 纪高飞. All rights reserved.
//

#import "CommentProblemCell.h"
#import "YNTUITools.h"
@implementation CommentProblemCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if ([super initWithStyle: style reuseIdentifier:reuseIdentifier]) {
        // 加载子视图
        [self setUpChildrenViews];
    }
    return  self;
}
- (void)setUpChildrenViews
{
    // 创建nameLab
    self.nameLab = [YNTUITools createLabel:CGRectMake(15 *kWidthScale , 14 *kHeightScale, KScreenW - 30 *kWidthScale, 18 *kHeightScale) text:nil textAlignment:NSTextAlignmentLeft textColor:nil bgColor:[UIColor whiteColor] font:18 *kHeightScale];
    
    [self.contentView addSubview:self.nameLab];
    

    // 创建箭头图片
    UIImageView *arrowImgView = [YNTUITools createImageView:CGRectMake(KScreenW - 23 *kWidthScale, 16 *kHeightScale, 8 *kWidthScale, 16*kHeightScale) bgColor:nil imageName:@"箭头"];
    
    [self.contentView addSubview:arrowImgView];
}
@end
