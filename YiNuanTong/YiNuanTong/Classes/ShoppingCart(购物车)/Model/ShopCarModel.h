//
//  ShopCarModel.h
//  1暖通购物车列表
//
//  Created by 1暖通商城 on 2017/4/5.
//  Copyright © 2017年 纪高飞. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ShopCarModel : NSObject

/**商品名*/
@property (nonatomic,copy) NSString * namestr;
/**商品价格(单价)*/
@property (nonatomic,copy) NSString *attrprice;
/**数量*/
@property (nonatomic,copy) NSString * num;
/**商品总价*/
@property (nonatomic,copy) NSString * xiaoprice;
/**是否选中*/
@property (nonatomic,assign) BOOL attr_select;
/**商品id*/
@property (nonatomic,copy) NSString *cat_attrid;

/**是否参与计算*/
@property (nonatomic,assign) BOOL isCount;
@end
