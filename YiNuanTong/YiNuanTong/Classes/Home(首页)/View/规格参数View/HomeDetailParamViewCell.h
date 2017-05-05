//
//  HomeDetailParamViewCell.h
//  YiNuanTong
//
//  Created by 1暖通商城 on 2017/4/20.
//  Copyright © 2017年 纪高飞. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeDetailParamViewCell : UITableViewCell
/**标题*/
@property (nonatomic,strong) UILabel *nameTitleLab;
/**副标题*/
@property (nonatomic,strong) UILabel *nameSubtitleLab;
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;

@end
