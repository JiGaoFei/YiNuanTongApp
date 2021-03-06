//
//  HomeShopListSizeModel.h
//  YiNuanTong
//
//  Created by 1暖通商城 on 2017/3/29.
//  Copyright © 2017年 纪高飞. All rights reserved.
//

#import "YNTBaseModel.h"

@interface HomeShopListSizeModel : YNTBaseModel
/**商品名*/
@property (nonatomic,copy) NSString  *name;
/**选中*/
@property (nonatomic,copy) NSString *select;
/**数量*/
@property (nonatomic,copy) NSString *num;
/**数量1*/
@property (nonatomic,copy) NSString *num1;
/**数量2*/
@property (nonatomic,copy) NSString *num2;
/**数量3*/
@property (nonatomic,copy) NSString *num3;
/** 总价(第1级的) */
@property (nonatomic,assign)  NSInteger  zongprice;
/**价钱*/
@property (nonatomic,copy) NSString *price;
/**价钱1*/
@property (nonatomic,copy) NSString *price1;
/**价钱2*/
@property (nonatomic,copy) NSString *price2;
/**价钱3*/
@property (nonatomic,copy) NSString *price3;
/**商品id获取时候用*/
@property (nonatomic,copy) NSString *attrid;
/**商品id获取跟服务器交互用*/
@property (nonatomic,copy) NSString *good_attid;
/**库存量*/
@property (nonatomic,copy) NSString *stock;
@property (nonatomic,assign) BOOL isHave;
/**选中状态*/
@property (nonatomic,copy) NSString * selectStatus;


@end
