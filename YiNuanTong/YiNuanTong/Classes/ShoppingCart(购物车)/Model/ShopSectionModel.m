//
//  ShopSectionModel.m
//  1暖通购物车列表
//
//  Created by 1暖通商城 on 2017/4/5.
//  Copyright © 2017年 纪高飞. All rights reserved.
//

#import "ShopSectionModel.h"
//15839459679 968900

@implementation ShopSectionModel
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
