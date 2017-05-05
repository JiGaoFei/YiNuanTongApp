//
//  OrderConfirmModel.m
//  YiNuanTong
//
//  Created by 1暖通商城 on 2017/4/11.
//  Copyright © 2017年 纪高飞. All rights reserved.
//

#import "OrderConfirmModel.h"

@implementation OrderConfirmModel
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.modelArr = [[NSMutableArray alloc]init];
        self.good_attr = [[NSMutableArray alloc]init];
        
    }
    return self;
}
- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}

@end
