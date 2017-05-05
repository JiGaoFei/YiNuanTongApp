//
//  OrderNewListModel.h
//  YiNuanTong
//
//  Created by 1暖通商城 on 2017/4/12.
//  Copyright © 2017年 纪高飞. All rights reserved.
//

#import "YNTBaseModel.h"

@interface OrderNewListModel : YNTBaseModel
/**该商品在订单中的id*/
@property (nonatomic,copy) NSString *good_id;
/**所属订单id*/
@property (nonatomic,copy) NSString *oid;
/**商品id*/
@property (nonatomic,copy) NSString *gid;
/**商品名称*/
@property (nonatomic,copy) NSString *name;
/**图片路径*/
@property (nonatomic,copy) NSString *cover_img;
/**价格*/
@property (nonatomic,copy) NSString *price;
/**商品数量*/
@property (nonatomic,copy) NSString *num;
/**商品价格*/
@property (nonatomic,copy) NSString *sum_price;
/**商品种数*/
@property (nonatomic,copy) NSString *zhong_num;
/**总数量*/
@property (nonatomic,copy) NSString *all_num;
@end
