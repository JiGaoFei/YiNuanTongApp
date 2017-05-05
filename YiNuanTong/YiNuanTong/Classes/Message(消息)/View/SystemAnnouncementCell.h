//
//  SystemAnnouncementCell.h
//  YiNuanTong
//
//  Created by 纪高飞 on 17/1/12.
//  Copyright © 2017年 纪高飞. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SystemAnnouncementModel;
@interface SystemAnnouncementCell : UITableViewCell
/**时间*/
@property (nonatomic,strong) UILabel  * timeLab;
/**titleLab*/
@property (nonatomic,strong) UILabel  * titleLab;
- (void)setValueWithModel:(SystemAnnouncementModel *)model;
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;
@end
