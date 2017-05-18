//
//  HomeBannerModel.h
//  YiNuanTong
//
//  Created by 纪高飞 on 17/5/18.
//  Copyright © 2017年 纪高飞. All rights reserved.
//

#import "YNTBaseModel.h"

@interface HomeBannerModel : YNTBaseModel
/**id*/
@property (nonatomic,copy) NSString * banner_id;
/**标题*/
@property (nonatomic,copy) NSString * title;
/**链接*/
@property (nonatomic,copy) NSString * url;
/**是否要要跳分类*/
@property (nonatomic,assign) NSInteger ishtml;
/**分类id*/
@property (nonatomic,copy) NSString * cat_id;

@end
