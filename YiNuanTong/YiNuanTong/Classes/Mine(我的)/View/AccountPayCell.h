//
//  AccountPayCell.h
//  YiNuanTong
//
//  Created by 纪高飞 on 16/12/30.
//  Copyright © 2016年 纪高飞. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AccountPayCell : UITableViewCell
/**Namelab*/
@property (nonatomic,strong) UILabel  * nameLab;
/**价格*/
@property (nonatomic,strong) UILabel  * priceLab;
/**时间*/
@property (nonatomic,strong) UILabel  * timeLab;
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;
@end
