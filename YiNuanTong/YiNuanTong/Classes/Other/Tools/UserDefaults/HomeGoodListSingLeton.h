//
//  HomeGoodListSingLeton.h
//  YiNuanTong
//
//  Created by 1暖通商城 on 2017/5/4.
//  Copyright © 2017年 纪高飞. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HomeGoodListSingLeton : NSObject

/**创建单例类*/
+ (HomeGoodListSingLeton *)shareHomeGoodListSingLeton;
/**品牌*/
@property (nonatomic,copy) NSString *brand;
/**分类*/
@property (nonatomic,strong) NSString *catBrand;
/**价格*/
@property (nonatomic,copy) NSString *price;
/**销量*/
@property (nonatomic,copy) NSString *xiaoLiang;
/**价格区间*/
@property (nonatomic,copy) NSString *qujian;



@end
