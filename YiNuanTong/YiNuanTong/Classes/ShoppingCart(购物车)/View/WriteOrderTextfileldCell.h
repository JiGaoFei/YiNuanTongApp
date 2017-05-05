//
//  WriteOrderTextfileldCell.h
//  YiNuanTong
//
//  Created by 纪高飞 on 16/12/27.
//  Copyright © 2016年 纪高飞. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WriteOrderTextfileldCell : UITableViewCell
/**nameLab*/
@property (nonatomic,strong) UILabel  * nameLab;
/**副标题*/
@property (nonatomic,strong) UITextField *textField;

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;

@end
