//
//  ShopGooodDetailMoreViewController.h
//  YiNuanTong
//
//  Created by 1暖通商城 on 2017/4/21.
//  Copyright © 2017年 纪高飞. All rights reserved.
//

#import "YNTBaseViewController.h"

@interface ShopGooodDetailMoreViewController : YNTBaseViewController
@property (nonatomic,strong) NSString  * good_id;
/** 是否收藏 */
@property (nonatomic,copy) NSString *isfavorite;
/**用于展示上边的图片的*/
@property (nonatomic,strong) NSString  * picUrl;
/**商品详情数据源*/
@property (nonatomic,strong) NSMutableDictionary *dataDic;
/**限制数量*/
@property (nonatomic,copy) NSString *  activitynum;
/**购买次数*/
@property (nonatomic,assign) NSInteger  order_count;

/**购物车购买次数*/
@property (nonatomic,assign) NSInteger  cart_count;


@end
