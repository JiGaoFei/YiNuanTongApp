//
//  HomeGoodDetailRecommandModel.h
//  YiNuanTong
//
//  Created by 1暖通商城 on 2017/4/20.
//  Copyright © 2017年 纪高飞. All rights reserved.
//

#import "YNTBaseModel.h"

@interface HomeGoodDetailRecommandModel : YNTBaseModel
/**商品id*/
@property (nonatomic,copy) NSString *good_id;
/**商品名称*/
@property (nonatomic,copy) NSString *name;
/**商品价格*/
@property (nonatomic,copy) NSString *price;
/**商品路径*/
@property (nonatomic,copy) NSString *cover_img;

@end
