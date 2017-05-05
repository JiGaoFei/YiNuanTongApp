//
//  GFTitleTableViewCell.h
//  YiNuanTong
//
//  Created by 1暖通商城 on 2017/4/8.
//  Copyright © 2017年 纪高飞. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GFTitleTableViewCell : UITableViewCell
@property (nonatomic,copy) void(^btnBlock)(NSInteger index);
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;
// 创建title
- (void)setTitleBtnValueWith:(NSMutableArray *)dataArray;
@end
