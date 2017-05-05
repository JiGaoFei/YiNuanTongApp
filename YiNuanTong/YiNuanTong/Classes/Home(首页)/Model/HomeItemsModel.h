//
//  HomeItemsModel.h
//  YiNuanTong
//
//  Created by 1暖通商城 on 2017/4/20.
//  Copyright © 2017年 纪高飞. All rights reserved.
//

#import "YNTBaseModel.h"

@interface HomeItemsModel : YNTBaseModel
/**商品id*/
@property (nonatomic,copy) NSString *good_id;
/**商品名称*/
@property (nonatomic,copy) NSString *name;
/**商品图片*/
@property (nonatomic,copy) NSString *image;
/**商品url*/
@property (nonatomic,copy) NSString *link_url;
@end
