//
//  NSString+DocumentFilePath.h
//  YiNuanTong
//
//  Created by 纪高飞 on 17/2/5.
//  Copyright © 2017年 纪高飞. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (DocumentFilePath)
//根据文件名字返回文件路径
+(NSString *)filePathWithName:(NSString *)name;

@end
