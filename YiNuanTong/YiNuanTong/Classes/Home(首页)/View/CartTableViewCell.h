//
//  CartTableViewCell.h
//  ArtronUp
//
//  Created by Artron_LQQ on 15/12/1.
//  Copyright © 2015年 ArtronImages. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HomeGoodsModel;



/**
 *  @author LQQ, 16-02-18 11:02:02
 *
 *  cell是否被选中的回调
 *
 *  @param select 是否被选中
 */
typedef void(^LQQCartBlock)(BOOL select);

/**
 *  @author LQQ, 16-02-18 11:02:48
 *
 *  数量改变的回调
 */

@interface CartTableViewCell : UITableViewCell

//数量
@property (nonatomic,retain)UILabel *numberLabel;
@property (nonatomic,assign)BOOL isSelected;
@property (nonatomic,copy)LQQCartBlock cartBlock;
//选中按钮
@property (nonatomic,strong) UIButton *selectBtn;
//显示照片
@property (nonatomic,strong) UIImageView *shopImageView;
//商品名
@property (nonatomic,strong) UILabel *nameLabel;
//商品编号
@property (nonatomic,strong) UILabel *shopNumberLabel;
//规格
@property (nonatomic,strong) UILabel *sizeLabel;
//时间
@property (nonatomic,strong) UILabel *dateLabel;
//价格
@property (nonatomic,strong) UILabel *priceLabel;
//删除按钮
@property (nonatomic,strong) UIButton *deleteBtn;
// 购物车按钮
@property (nonatomic,strong) UIButton *listCarBtn;
// 选择添加购物车的回调
@property (nonatomic,copy) void(^addCarBlock)();
-(void)reloadDataWith:(HomeGoodsModel*)model;
@end
