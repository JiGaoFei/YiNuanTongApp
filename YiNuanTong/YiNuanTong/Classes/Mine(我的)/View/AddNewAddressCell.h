//
//  AddNewAddressCell.h
//  YiNuanTong
//
//  Created by 纪高飞 on 16/12/26.
//  Copyright © 2016年 纪高飞. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddNewAddressCell : UITableViewCell
/**'nameLab*/
@property (nonatomic,strong) UILabel  * nameLab;
/**textField*/
@property (nonatomic,strong) UITextField  * textField;
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;
@end
