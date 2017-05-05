//
//  OptionCell.m
//  YiNuanTong
//
//  Created by 纪高飞 on 16/12/26.
//  Copyright © 2016年 纪高飞. All rights reserved.
//

#import "OptionCell.h"
#import "YNTUITools.h"
#import "MineConmentListModel.h"
#import "UIImageView+WebCache.h"
@implementation OptionCell

 - (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if ([super initWithStyle: style reuseIdentifier:reuseIdentifier]) {
        // 加载子视图
        [self setUpChidrenViews];
    }
    return self;
}
 - (void)setUpChidrenViews
{
    // 创建头像
    self.imgView = [YNTUITools createImageView: CGRectMake(27*kPlus, 10, 99*kPlus, 99*kPlus) bgColor:[UIColor whiteColor] imageName:@"女9"];
    [self.contentView addSubview:self.imgView];
    // 创建时间lab
    self.timeLab = [YNTUITools createLabel:CGRectMake(CGRectGetMaxX(self.imgView.frame) + 9, 20, 100, 12) text:nil textAlignment:NSTextAlignmentLeft textColor:nil bgColor:nil font:12];
    [self.contentView addSubview:self.timeLab];
    // 创建内容lab
    self.contentLab = [YNTUITools createLabel:CGRectMake(CGRectGetMaxX(self.imgView.frame) + 9, 20, KScreenW - 70, 14) text:nil textAlignment:NSTextAlignmentLeft textColor:nil bgColor:nil font:14];
    self.contentLab.numberOfLines = 0;
    [self.contentView addSubview:self.contentLab];
    
    

    
}
- (void)setValueWithModel:(MineConmentListModel *)model
{
    [self.imgView sd_setImageWithURL:[NSURL URLWithString:model.image]];
    self.timeLab.text = model.addtime;
    self.contentLab.text = model.content;
    NSDictionary *fontDic=@{NSFontAttributeName:[UIFont systemFontOfSize:14]};
    CGSize size1=CGSizeMake(KScreenW,0);
    CGSize titleLabelSize=[model.content boundingRectWithSize:size1 options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading   attributes:fontDic context:nil].size;
    if (titleLabelSize.height < 30) {
        self.contentLab.frame = CGRectMake(70, 25, KScreenW - 70, titleLabelSize.height + 35);
    }else
    {
         self.contentLab.frame = CGRectMake(70, 35, KScreenW - 70, titleLabelSize.height + 45);
    }
 
    

 
}
@end
