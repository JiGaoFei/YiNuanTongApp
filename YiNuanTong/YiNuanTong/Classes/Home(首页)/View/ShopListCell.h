//
//  ShopListCell.h
//  YiNuanTong
//
//  Created by 纪高飞 on 16/12/20.
//  Copyright © 2016年 纪高飞. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HomeShopListModel;
@interface ShopListCell : UITableViewCell
//显示照片
@property (nonatomic,strong) UIImageView *listImageView;
//商品名
@property (nonatomic,strong) UILabel *listNameLabel;
//规格
@property (nonatomic,strong) UILabel *listSizeLabel;
//商品价格
@property (nonatomic,strong) UILabel *listPriceLabel;
//是否是新产品
@property (nonatomic,strong) UILabel *newlab;
// 购物车btn
@property (nonatomic,strong) UIButton *listCarBtn;
@property (nonatomic,copy) void(^carBtnClicked)(NSInteger index);
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;
- (void)setValueWithMode:(HomeShopListModel *)model;
@end
