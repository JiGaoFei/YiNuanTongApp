//
//  OptionCell.h
//  YiNuanTong
//
//  Created by 纪高飞 on 16/12/26.
//  Copyright © 2016年 纪高飞. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MineConmentListModel;
@interface OptionCell : UITableViewCell
/**头像*/
@property (nonatomic,strong) UIImageView  * imgView ;
/**时间 */
@property (nonatomic,strong) UILabel  * timeLab;
/**内容*/
@property (nonatomic,strong) UILabel  * contentLab;
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;
- (void)setValueWithModel:(MineConmentListModel *)model;
@end
