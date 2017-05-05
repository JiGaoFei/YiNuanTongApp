//
//  MineConmentListModel.h
//  YiNuanTong
//
//  Created by 纪高飞 on 17/1/10.
//  Copyright © 2017年 纪高飞. All rights reserved.
//

#import "YNTBaseModel.h"

@interface MineConmentListModel : YNTBaseModel
/**时间*/
@property (nonatomic,strong) NSString  * addtime;
/**内容*/
@property (nonatomic,strong) NSString  * content;
/**图片路径*/
@property (nonatomic,strong) NSString  * image;
/**用户名*/
@property (nonatomic,strong) NSString  * username;
@end
