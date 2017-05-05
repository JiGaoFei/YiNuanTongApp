//
//  WritePaymentAccountCell.h
//  YiNuanTong
//
//  Created by 纪高飞 on 16/12/27.
//  Copyright © 2016年 纪高飞. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WritePaymentAccountCell : UITableViewCell
/**titleLab*/
@property (nonatomic,strong) UILabel  * titleLab;
/**银行名*/
@property (nonatomic,strong) UILabel  * bankNameLab;
/**账户名称*/
@property (nonatomic,strong) UILabel  * accountLab;
/**开户账号*/
@property (nonatomic,strong) UILabel  * accountNumLab;

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;


@end
