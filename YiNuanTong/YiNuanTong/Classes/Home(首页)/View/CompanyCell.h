//
//  CompanyCell.h
//  YiNuanTong
//
//  Created by 纪高飞 on 16/12/13.
//  Copyright © 2016年 纪高飞. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UITextField+IndexPath.h"

@protocol  CompanyCellDelegate <NSObject>

@required
// cell的textField文本发生改变时回调
- (void)cellTextFieldChange:(NSString *)str  forIndexPath:(NSIndexPath *)indexPath;
@end
@interface CompanyCell : UITableViewCell
/**
 *cell中textField
 */
@property (nonatomic,strong) UITextField *textFiled;
/**delegate属性*/
@property (nonatomic,assign) id <CompanyCellDelegate>delegate;

@end
