//
//  GoodDetailBtnView.h
//  YiNuanTong
//
//  Created by 纪高飞 on 16/12/28.
//  Copyright © 2016年 纪高飞. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GoodDetailBtnView : UIView
/**产品介绍btn*/
@property (nonatomic,strong) UIButton  * productBtn;
/**规格参数btn*/
@property (nonatomic,strong) UIButton  * sizeBtn;
/**蓝色线条*/
@property (nonatomic,strong) UILabel  * blueLineLab;
/**按钮点击事件的回调*/
@property (nonatomic,copy) void(^btnClicked)(NSInteger index) ;
- (instancetype)initWithFrame:(CGRect)frame;
@end
