//
//  GFChooseOneViewCell.h
//  YiNuanTong
//
//  Created by 1暖通商城 on 2017/4/21.
//  Copyright © 2017年 纪高飞. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HomeShopListSizeModel;
@class GoodDetailAttrtypeModel;
@interface GFChooseOneViewCell : UITableViewCell
/**勾选按钮*/
@property (nonatomic,strong) UIButton  * selectBtn;
/**商品信息*/
@property (nonatomic,strong) UILabel  * shopNameLabel;
/**商品价格*/
@property (nonatomic,strong) UILabel  * shopPriceLabel;
/**数字*/
@property (nonatomic,strong) UITextField  * numberTextField;
/**加号按钮*/
@property (nonatomic,strong)  UIButton *addBtn;
/**减号按钮*/
@property (nonatomic,strong)  UIButton *cutBtn;
/**库存*/
@property (nonatomic,strong) UILabel *stockNumLab;
/**加号按钮的回调*/
@property (nonatomic,copy) void (^addBtnBloock)(NSString *str);
/**减号按钮的回调*/
@property (nonatomic,copy) void (^cutBtnBloock)(NSString *str);
/**完成按钮的回调事件*/
@property (nonatomic,copy) void (^confirmBtnBlock)();
/**把输入后的值传递出去*/
@property (nonatomic,copy) void (^numberTextFiledInputText)(NSString* str);
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;
// 多属性组合调用此方法
- (void)setValueWithModel:(HomeShopListSizeModel *)model andWithAttryModel:(GoodDetailAttrtypeModel *)attrModle;
// 多属性合一调用此方法
- (void)setValueWithModel:(HomeShopListSizeModel *)model;
@end
