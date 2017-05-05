//
//  HomeShopListDetailModel.h
//  YiNuanTong
//
//  Created by 1暖通商城 on 2017/3/28.
//  Copyright © 2017年 纪高飞. All rights reserved.
//

#import "YNTBaseModel.h"

@interface HomeShopListDetailModel : YNTBaseModel
/**商品名字*/
@property (nonatomic,copy) NSString *name;
/**商品价格*/
@property (nonatomic,copy) NSString  *price;
/** 商品规格信息 */
@property (nonatomic,strong) NSMutableArray *tianxie;
/** 图片数组 */
@property (nonatomic,strong) NSMutableArray *xiangce;
/**市场价格*/
@property (nonatomic,copy) NSString *market_price;
/**已成交数量*/
@property (nonatomic,copy) NSString *sale_num;
/**快递*/
@property (nonatomic,copy) NSString *shipping;
/**发货地*/
@property (nonatomic,copy) NSString *shippadd;
@end
