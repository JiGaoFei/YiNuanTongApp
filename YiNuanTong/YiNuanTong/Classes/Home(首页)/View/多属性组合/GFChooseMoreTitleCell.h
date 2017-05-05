//
//  GFChooseMoreTitleCell.h
//  YiNuanTong
//
//  Created by 1暖通商城 on 2017/4/22.
//  Copyright © 2017年 纪高飞. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HomeShopListSizeModel;
@interface GFChooseMoreTitleCell : UITableViewCell
/** 名称 */
@property (nonatomic,strong)UILabel*nameLab;
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;
- (void)setValueWithModel:(HomeShopListSizeModel *)model;
@end
