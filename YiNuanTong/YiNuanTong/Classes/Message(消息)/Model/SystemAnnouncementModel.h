//
//  SystemAnnouncementModel.h
//  YiNuanTong
//
//  Created by 纪高飞 on 17/1/12.
//  Copyright © 2017年 纪高飞. All rights reserved.
//

#import "YNTBaseModel.h"

@interface SystemAnnouncementModel : YNTBaseModel
/**文章标题*/
@property (nonatomic,strong) NSString  * title;
/**文章id*/
@property (nonatomic,strong) NSString  * article_id;
/**文章时间 */
@property (nonatomic,strong) NSString  * createtime;
/**文章链接*/
@property (nonatomic,strong) NSString  * article_url;

@end
