//
//  ShopCarCell.h
//  YiNuanTong
//
//  Created by 纪高飞 on 16/12/17.
//  Copyright © 2016年 纪高飞. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShopCartModel.h"
/**
 *cell 是否被选中
 *@param select  是否被选中
 */
typedef void(^ShopCarBlock) (BOOL select);
/**
 *数量改变的回调
 */
typedef void (^ShopCarNumChange)();


@interface ShopCarCell : UITableViewCell
// 数量

@property (nonatomic,strong) UITextField *numberTextField;
@property (nonatomic,assign) BOOL isSelected;
@property (nonatomic,copy) ShopCarBlock carBlock;
@property (nonatomic,copy) ShopCarNumChange numberAddBlock;
@property (nonatomic,copy) ShopCarNumChange numberCuttBlock;
/**
 *刷新数据 传数据模型
 */
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
/**删除按钮的回调事件*/
@property (nonatomic,copy) void(^deleteBtnBlock)();
/**完成按钮的回调事件*/
@property (nonatomic,copy) void (^confirmBtnBlock)();
/**把输入后的值传递出去*/
@property (nonatomic,copy) void (^numberTextFiledInputText)(NSString* str);


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;
- (void)setDataWithModel:(ShopCartModel *)model;
@end;
