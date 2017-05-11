//
//  OrderCollectionViewCell.h
//  多属性角标
//
//  Created by 1暖通商城 on 2017/5/8.
//  Copyright © 2017年 1暖通商城. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OrderCollectionViewCell : UICollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame;
@property (nonatomic,strong)UILabel*nameLab;
@property (nonatomic,strong)UILabel *cornerMarkLab;
@property (nonatomic,strong)UIView *bagView;
- (void)setCellStyle;

@end
