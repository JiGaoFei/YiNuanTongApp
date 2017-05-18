//
//  ShopSectionModel.h
//  1暖通购物车列表
//
//  Created by 1暖通商城 on 2017/4/5.
//  Copyright © 2017年 纪高飞. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface ShopSectionModel : NSObject
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
/**directbuy*/
@property (nonatomic,copy) NSString *directbuy;
/**cat_id*/
@property (nonatomic,copy) NSString *cat_id;
/**单件商品的个数*/
@property (nonatomic,copy) NSString *num;
/**商品是否选中*/
@property (nonatomic,assign) BOOL good_sele;
/**总商品数量*/
@property (nonatomic,assign) NSInteger good_num;
/**总商品各类数*/
@property (nonatomic,assign) NSInteger good_zhong;
/**总商品价格*/
@property (nonatomic,assign) double good_price;
/**分区中商品数据*/
@property (nonatomic,strong) NSMutableArray *good_attr;
/**存放分区中的model*/
@property (nonatomic,strong) NSMutableArray *modelArr;
/**限购数量*/
@property (nonatomic,assign) NSInteger  activitynum;


/** 是否展开 */
@property (nonatomic,assign) BOOL isOpen;
- (NSMutableArray *)setValueWithArr:(NSArray *)arr;
- (instancetype)init;

@end
