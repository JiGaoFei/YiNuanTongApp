//
//  AccountCell.h
//  YiNuanTong
//
//  Created by 纪高飞 on 16/12/15.
//  Copyright © 2016年 纪高飞. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AccountCell : UICollectionViewCell

/**账户lab*/
@property (nonatomic,strong) UILabel  * accountLab;
/**账户余额lab*/
@property (nonatomic,strong) UILabel  *accountDetailLab;
/**中间线图片*/
@property (nonatomic,strong) UILabel  * lineLab;

-(instancetype)initWithFrame:(CGRect)frame;
@end
