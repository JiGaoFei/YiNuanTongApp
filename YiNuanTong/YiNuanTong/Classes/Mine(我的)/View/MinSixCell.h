//
//  MinSixCell.h
//  YiNuanTong
//
//  Created by 纪高飞 on 16/12/16.
//  Copyright © 2016年 纪高飞. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MinSixCell : UICollectionViewCell
/**图片*/
@property (nonatomic,strong) UIImageView  * imageView;
/**名称 */
@property (nonatomic,strong) UILabel  * nameLab;
- (instancetype)initWithFrame:(CGRect)frame;
@end
