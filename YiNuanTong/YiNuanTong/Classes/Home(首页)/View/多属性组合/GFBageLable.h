//
//  GFBageLable.h
//  YiNuanTong
//
//  Created by 1暖通商城 on 2017/4/22.
//  Copyright © 2017年 纪高飞. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GFBageLable : UILabel
/** 显示按钮角标的label */
@property (nonatomic,strong) UILabel *badgeLabel;
@property (nonatomic, strong)UILabel *cornerMarkLB;
- (void)showBadgeWithNumber:(NSInteger)badgeNumber;
- (void)hideBadge;
@end
