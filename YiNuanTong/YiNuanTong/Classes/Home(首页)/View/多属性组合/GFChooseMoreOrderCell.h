//
//  GFChooseMoreOrderCell.h
//  YiNuanTong
//
//  Created by 纪高飞 on 17/5/11.
//  Copyright © 2017年 纪高飞. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GFChooseMoreOrderCell : UITableViewCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;
- (void)setValueWithModelArray:(NSMutableArray *)modelArray;
@end
