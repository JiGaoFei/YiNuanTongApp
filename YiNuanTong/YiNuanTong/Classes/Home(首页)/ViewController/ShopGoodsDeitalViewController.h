//
//  ShopGoodsDeitalViewController.h
//  YiNuanTong
//
//  Created by 纪高飞 on 16/12/20.
//  Copyright © 2016年 纪高飞. All rights reserved.
//

#import "YNTBaseViewController.h"

@interface ShopGoodsDeitalViewController : YNTBaseViewController
/**用于属性传值商品id*/
@property (nonatomic,strong) NSString  * good_id;
/**用于属性传值是否收藏*/
 @property (nonatomic,strong) NSString  * isfavorite;
/**用于展示上边的图片的*/
@property (nonatomic,strong) NSString  * picUrl;
/**商品详情数据源*/
@property (nonatomic,strong) NSMutableDictionary *dataDic;
@end
