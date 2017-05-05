//
//  OrderTransportCell.h
//  YiNuanTong
//
//  Created by 纪高飞 on 16/12/21.
//  Copyright © 2016年 纪高飞. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OrderTransportCell : UITableViewCell
/**titleLab*/
@property (nonatomic,strong) UILabel  * titleLab;
/**contentLab*/
@property (nonatomic,strong) UILabel  * contentLab;
/**timeLab*/
@property (nonatomic,strong) UILabel  * timeLab;
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;
@end
