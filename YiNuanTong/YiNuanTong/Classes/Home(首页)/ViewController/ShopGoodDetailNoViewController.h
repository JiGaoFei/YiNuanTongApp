//
//  ShopGoodDetailNoViewController.h
//  YiNuanTong
//
//  Created by 1暖通商城 on 2017/4/21.
//  Copyright © 2017年 纪高飞. All rights reserved.
//

#import "YNTBaseViewController.h"

@interface ShopGoodDetailNoViewController : YNTBaseViewController
/**用于属性传值商品id*/
@property (nonatomic,strong) NSString  * good_id;
/** 是否收藏 */
@property (nonatomic,copy) NSString *isfavorite;
/**用于展示上边的图片的*/
@property (nonatomic,strong) NSString  * picUrl;
/**商品详情数据源*/
@property (nonatomic,strong) NSMutableDictionary *dataDic;

@end
