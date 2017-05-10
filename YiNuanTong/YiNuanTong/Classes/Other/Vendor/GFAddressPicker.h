//
//  GFAddressPicker.h
//  地址选择器
//
//  Created by 1暖通商城 on 2017/5/10.
//  Copyright © 2017年 1暖通商城. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol GFAddressPickerDelegate <NSObject>
@optional
- (void)GFAddressPickerWithProvince:(NSString *)province
                                          city:(NSString *)city town:(NSString *)area;
- (void)GFAddressPickerCancleAction;
@end
@interface GFAddressPicker : UIView

/** 省 */
@property (nonatomic, strong) NSString *province;
/** 市 */
@property (nonatomic, strong) NSString *city;
/** 区 */
@property (nonatomic, strong) NSString *town;
@property (nonatomic, weak) id<GFAddressPickerDelegate> delegate;
- (void)updateAddressAtProvince:(NSString *)province city:(NSString *)city town:(NSString *)town;
/** 内容字体 */
@property (nonatomic, strong) UIFont *font;
@end