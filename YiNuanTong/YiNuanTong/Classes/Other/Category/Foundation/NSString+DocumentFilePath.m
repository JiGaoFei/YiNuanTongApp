//
//  NSString+DocumentFilePath.m
//  YiNuanTong
//
//  Created by 纪高飞 on 17/2/5.
//  Copyright © 2017年 纪高飞. All rights reserved.
//

#import "NSString+DocumentFilePath.h"

@implementation NSString (DocumentFilePath)
+(NSString *)filePathWithName:(NSString *)name
{
    
    NSString *documents = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    
    return [documents stringByAppendingPathComponent:name];
    
}


@end
