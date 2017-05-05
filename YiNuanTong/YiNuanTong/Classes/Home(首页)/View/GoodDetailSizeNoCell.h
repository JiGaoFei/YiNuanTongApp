//
//  GoodDetailSizeNoCell.h
//  YiNuanTong
//
//  Created by 1暖通商城 on 2017/4/21.
//  Copyright © 2017年 纪高飞. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GoodDetailSizeNoCell : UITableViewCell
/**数字*/
@property (nonatomic,strong) UITextField  * numberTextField;
/**加号按钮*/
@property (nonatomic,strong)  UIButton *addBtn;
/**减号按钮*/
@property (nonatomic,strong)  UIButton *cutBtn;

/**加号按钮的回调*/
@property (nonatomic,copy) void (^addBtnBloock)(NSString *str);
/**减号按钮的回调*/
@property (nonatomic,copy) void (^cutBtnBloock)(NSString *str);
/**完成按钮的回调事件*/
@property (nonatomic,copy) void (^confirmBtnBlock)();
/**把输入后的值传递出去*/
@property (nonatomic,copy) void (^numberTextFiledInputText)(NSString* str);

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;
@end
