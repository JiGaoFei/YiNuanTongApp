//
//  OrderNewDetailSectionModel.h
//  YiNuanTong
//
//  Created by 1暖通商城 on 2017/4/12.
//  Copyright © 2017年 纪高飞. All rights reserved.
//

#import "YNTBaseModel.h"

@interface OrderNewDetailSectionModel : YNTBaseModel

/**商品在订单中的id */
@property (nonatomic,copy) NSString *good_id;
/**商品数量无多属性时使用*/
@property (nonatomic,copy) NSString *num;
/**商品名字*/
@property (nonatomic,copy) NSString *good_name;
/**商品单价*/
@property (nonatomic,copy) NSString *price;
/**商品总数量有多属性时使用*/
@property (nonatomic,copy) NSString *good_num;
/**商品总价有多属性时使用*/
@property (nonatomic,copy) NSString *good_price;
/**商品总价有多属性时使用*/
@property (nonatomic,copy) NSString *good_img;
/**商品种类数量无多属性时使用时为0*/
@property (nonatomic,copy) NSString *good_zhong;
/**商品id*/
@property (nonatomic,copy) NSString *gid;
@property (nonatomic,strong) NSMutableArray *good_attr;

/**存放分区中的model*/
@property (nonatomic,strong) NSMutableArray *modelArr;
/** 是否展开 */
@property (nonatomic,assign) BOOL isOpen;
- (instancetype)init;

@end
