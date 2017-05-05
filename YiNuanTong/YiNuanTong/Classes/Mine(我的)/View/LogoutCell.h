//
//  LogoutCell.h
//  YiNuanTong
//
//  Created by 纪高飞 on 16/12/22.
//  Copyright © 2016年 纪高飞. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LogoutCell : UICollectionViewCell
/**按钮点击事件的回调*/
@property (nonatomic,copy) void (^buttonClicked)(NSInteger index);
/**退出按钮*/
@property (nonatomic,strong) UIButton  * logoutBtn;
- (instancetype)initWithFrame:(CGRect)frame;
@end
