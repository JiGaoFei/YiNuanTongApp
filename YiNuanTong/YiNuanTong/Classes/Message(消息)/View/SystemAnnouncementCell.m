//
//  SystemAnnouncementCell.m
//  YiNuanTong
//
//  Created by 纪高飞 on 17/1/12.
//  Copyright © 2017年 纪高飞. All rights reserved.
//

#import "SystemAnnouncementCell.h"
#import "YNTUITools.h"
#import "SystemAnnouncementModel.h"
@implementation SystemAnnouncementCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if ([super initWithStyle: style reuseIdentifier:reuseIdentifier]) {
        
        // 创建视图
        [self setUpChildrenViews];
    }
    return self;
}
// 创建视图
- (void)setUpChildrenViews
{
    // 创建时间lab
    self.timeLab = [YNTUITools createLabel:CGRectMake(275 *kPlus, 20 *kPlus, KScreenW - 275 *2 *kPlus, 25) text:nil textAlignment:NSTextAlignmentCenter textColor:[UIColor whiteColor] bgColor:RGBA(153, 153, 153, 1)  font:17];
    self.timeLab.layer.cornerRadius = 5;
    self.timeLab.layer.masksToBounds = YES;
    [self.contentView addSubview:self.timeLab];
    
    
    UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(43 *kPlus, 45, KScreenW - 43 *2 *kPlus, 70)];
    backView.backgroundColor = [UIColor whiteColor];
    backView.layer.cornerRadius = 10;
    backView.layer.masksToBounds = YES;
    [self.contentView addSubview:backView];
    // 创建时间lab
    self.titleLab = [YNTUITools createLabel:CGRectMake(40*kPlus, 25, 290, 25) text:nil textAlignment:NSTextAlignmentLeft textColor:nil bgColor:[UIColor whiteColor]  font:20];
   
    [backView addSubview:self.titleLab];

}
- (void)setValueWithModel:(SystemAnnouncementModel *)model
{
    self.titleLab.text = model.title;
    self.timeLab.text = model.createtime;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
