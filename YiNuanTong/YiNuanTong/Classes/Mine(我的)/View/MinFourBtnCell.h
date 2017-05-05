//
//  MinFourBtnCell.h
//  YiNuanTong
//
//  Created by 纪高飞 on 16/12/16.
//  Copyright © 2016年 纪高飞. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MinFourBtnCell : UICollectionViewCell
/**待付款btn*/
@property (nonatomic,strong) UIButton   * noPayBtn;
/**待发货btn*/
@property (nonatomic,strong) UIButton   * noSendBtn;
/**待收货btn*/
@property (nonatomic,strong) UIButton   * noAcceptBtn;
/**已完成btn*/
@property (nonatomic,strong) UIButton   * comepleteBtn;
/**点击按钮的回调方法*/
@property (nonatomic,copy) void (^buttonClicked) (NSInteger tag);
-(instancetype)initWithFrame:(CGRect)frame;

@end
