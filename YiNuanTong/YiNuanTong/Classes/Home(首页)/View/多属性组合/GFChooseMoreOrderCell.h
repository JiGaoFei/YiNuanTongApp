//
//  GFChooseMoreOrderCell.h
//  YiNuanTong
//
//  Created by 纪高飞 on 17/5/11.
//  Copyright © 2017年 纪高飞. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GFChooseMoreOrderCell : UITableViewCell
/**点击回调*/
@property (nonatomic,copy)  void (^clickedCollectionCellBlock)(NSInteger row, NSString *good_id);
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;
/**赋值*/
- (void)setValueWithModelArray:(NSMutableArray *)modelArray;

@end
