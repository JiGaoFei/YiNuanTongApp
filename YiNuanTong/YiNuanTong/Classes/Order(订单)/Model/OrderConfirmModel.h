//
//  OrderConfirmModel.h
//  YiNuanTong
//
//  Created by 1暖通商城 on 2017/4/11.
//  Copyright © 2017年 纪高飞. All rights reserved.
//

#import "YNTBaseModel.h"

@interface OrderConfirmModel : YNTBaseModel
/**uid*/
@property (nonatomic,copy) NSString *uid;
/**商品id*/
@property (nonatomic,copy) NSString *gid;
/**商品图片路径*/
@property (nonatomic,copy) NSString *good_img;
/**商品名*/
@property (nonatomic,copy) NSString *good_name;
/**aid*/
@property (nonatomic,copy) NSString *aid;
/**价格*/
@property (nonatomic,copy) NSString *price;
/**商品数量无属性*/
@property (nonatomic,copy) NSString *num;
/**directbuy*/
@property (nonatomic,copy) NSString *directbuy;
/**cat_id*/
@property (nonatomic,copy) NSString *cat_id;
/**商品是否选中*/
@property (nonatomic,assign) BOOL good_sele;
/**商品数量*/
@property (nonatomic,assign) NSInteger good_num;
/**商品价格*/
@property (nonatomic,assign) double good_price;
/**分区中商品数据*/
@property (nonatomic,strong) NSMutableArray *good_attr;
/**是否多属性*/
@property (nonatomic,strong) NSMutableArray *good_zhong;
/**存放分区中的model*/
@property (nonatomic,strong) NSMutableArray *modelArr;
/** 是否展开 */
@property (nonatomic,assign) BOOL isOpen;
- (NSMutableArray *)setValueWithArr:(NSArray *)arr;
- (instancetype)init;

@end
