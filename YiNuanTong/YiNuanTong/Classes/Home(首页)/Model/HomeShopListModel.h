//
//  HomeShopListModel.h
//  YiNuanTong
//
//  Created by 1暖通商城 on 2017/3/28.
//  Copyright © 2017年 纪高飞. All rights reserved.
//

#import "YNTBaseModel.h"

@interface HomeShopListModel : YNTBaseModel

/**商品名字*/
@property (nonatomic,copy) NSString *name;
/**图片路径*/
@property (nonatomic,copy) NSString *cover_img;
/**商品id*/
@property (nonatomic,copy) NSString *good_id;
/**价格*/
@property (nonatomic,copy) NSString *price;
/**是否是新的 1是*/
@property (nonatomic,assign) NSInteger  is_new;






@end
