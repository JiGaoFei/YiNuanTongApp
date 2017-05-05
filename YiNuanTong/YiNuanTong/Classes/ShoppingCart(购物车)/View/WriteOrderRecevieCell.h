//
//  WriteOrderRecevieCell.h
//  YiNuanTong
//
//  Created by 纪高飞 on 16/12/27.
//  Copyright © 2016年 纪高飞. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WriteOrderRecevieCell : UITableViewCell
/**titleLab*/
@property (nonatomic,strong) UILabel  * titleLab;
/**nameLab*/
@property (nonatomic,strong) UILabel  * nameLab;
/**电话*/
@property (nonatomic,strong) UILabel  * phoneLab;
/**地址*/
@property (nonatomic,strong) UILabel  * addressLab;
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;

@end
