//
//  MineCompanyModel.h
//  YiNuanTong
//
//  Created by 1暖通商城 on 2017/4/26.
//  Copyright © 2017年 纪高飞. All rights reserved.
//

#import "YNTBaseModel.h"

@interface MineCompanyModel : YNTBaseModel
/**用户id*/
@property (nonatomic,copy) NSString *user_id;
/**电话*/
@property (nonatomic,copy) NSString *phone;
/**用户名*/
@property (nonatomic,copy) NSString *username;
/**环信id*/
@property (nonatomic,copy) NSString *huanxin_id;
/**头像路径*/
@property (nonatomic,copy) NSString *avatar;
/**address*/
@property (nonatomic,copy) NSString *address;
/**名字*/
@property (nonatomic,copy) NSString *realname;
/**固话*/
@property (nonatomic,copy) NSString *tel;
/**传真*/
@property (nonatomic,copy) NSString *fax;
/**营业执照路径*/
@property (nonatomic,copy) NSString *zhizhao;
/**身份证正面*/
@property (nonatomic,copy) NSString *idcardfront;
/**门店1*/
@property (nonatomic,copy) NSString *mendian1;
/**门店2*/
@property (nonatomic,copy) NSString *mendian2;
/**身份证北面*/
@property (nonatomic,copy) NSString *idcardback;
/**省*/
@property (nonatomic,copy) NSString *province;
/**市*/
@property (nonatomic,copy) NSString *city;
/**区*/
@property (nonatomic,copy) NSString *area;


@end
