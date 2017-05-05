//
//  CommenProblemModel.m
//  YiNuanTong
//
//  Created by 1暖通商城 on 2017/4/18.
//  Copyright © 2017年 纪高飞. All rights reserved.
//

#import "CommenProblemModel.h"

@implementation CommenProblemModel
- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    if ([key isEqualToString:@"id"]) {
        self.problem_id = value;
    }
}
@end
