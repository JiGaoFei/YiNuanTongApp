//
//  OrderTransprotLabCell.h
//  YiNuanTong
//
//  Created by 纪高飞 on 16/12/21.
//  Copyright © 2016年 纪高飞. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OrderTransprotLabCell : UITableViewCell
/**titleLab*/
@property (nonatomic,strong) UILabel  * titleLab;
/**contentLab*/
@property (nonatomic,strong) UILabel  * contentLab;
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;
@end
