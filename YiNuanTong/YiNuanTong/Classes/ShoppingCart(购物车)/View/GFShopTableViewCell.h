//
//  GFShopTableViewCell.h
//  1暖通购物车列表
//
//  Created by 纪高飞 on 17/4/2.
//  Copyright © 2017年 纪高飞. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GFShopTableViewCell : UITableViewCell
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
/**加号按钮的回调*/
@property (nonatomic,copy) void (^addBtnBloock)(NSString *str);
/**减号按钮的回调*/
@property (nonatomic,copy) void (^cutBtnBloock)(NSString *str);
/**完成按钮的回调事件*/
@property (nonatomic,copy) void (^confirmBtnBlock)();
/**把输入后的值传递出去*/
@property (nonatomic,copy) void (^numberTextFiledInputText)(NSString* str);
/**勾选按钮回调事件*/
@property (nonatomic,copy) void(^selectBtnBlock)(BOOL isSelect);
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;
@end
