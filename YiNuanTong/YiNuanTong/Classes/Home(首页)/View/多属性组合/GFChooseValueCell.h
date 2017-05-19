//
//  GFChooseValueCell.h
//  YiNuanTong
//
//  Created by 纪高飞 on 17/5/19.
//  Copyright © 2017年 纪高飞. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HomeShopListSizeModel;
@interface GFChooseValueCell : UITableViewCell
/** 名称 */
@property (nonatomic,strong)UILabel*nameLab;
@property (nonatomic, strong)UILabel *cornerMarkLB;///角标

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;
- (void)setValueWithModel:(HomeShopListSizeModel *)model;
@end
