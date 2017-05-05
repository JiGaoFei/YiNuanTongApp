//
//  HomeGoodsModel.h
//  YiNuanTong
//
//  Created by 纪高飞 on 17/1/7.
//  Copyright © 2017年 纪高飞. All rights reserved.
//

#import "YNTBaseModel.h"

@interface HomeGoodsModel : YNTBaseModel
/**商品名*/
@property (nonatomic,strong) NSString  * name;
/**库存*/
@property (nonatomic,strong) NSString  * stocknum;
/**售价*/
@property (nonatomic,strong) NSString  * price;
/**图片路径 */
@property (nonatomic,strong) NSString  * cover_img;
/**规格数*/
@property (nonatomic,assign) NSInteger sizecount;
/**商品id*/
@property (nonatomic,strong) NSString  * good_id;
/**商品规格*/
@property (nonatomic,strong) NSMutableArray  * sizeinfo;
/**商品是否收藏*/
@property (nonatomic,strong) NSString  * isfavorite;
@end
