//
//  CommentProblemCell.h
//  YiNuanTong
//
//  Created by 纪高飞 on 16/12/26.
//  Copyright © 2016年 纪高飞. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CommentProblemCell : UITableViewCell
/**'nameLab*/
@property (nonatomic,strong) UILabel  * nameLab;
/**detailNameLab*/
@property (nonatomic,strong) UILabel  * detailNameLab;

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;

@end
