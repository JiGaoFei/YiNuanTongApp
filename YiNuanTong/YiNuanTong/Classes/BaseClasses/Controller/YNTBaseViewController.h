//
//  YNTBaseViewController.h
//  YiNuanTong
//
//  Created by 纪高飞 on 16/12/12.
//  Copyright © 2016年 纪高飞. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YNTBaseViewController : UIViewController
/**显示加载圈,title为加载圈上要显示的内容*/
- (void)showHUD:(NSString *)title;
/**隐藏加载圈*/
- (void)hiddenHUD;
- (void)setUpPlaceholdViews;
@end
