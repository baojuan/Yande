//
//  IOManager.m
//  Yande
//
//  Created by 南 篤良 on 14-1-12.
//  Copyright (c) 2014年 南 篤良. All rights reserved.
//

#import "IOManager.h"

@implementation IOManager

+ (BOOL)writeFile:(NSData *)data Name:(NSString *)name Path:(NSString *)path
{
    return [[NSFileManager defaultManager] createFileAtPath:[self filePath:name Path:path] contents:data attributes:nil];
}

+ (NSData *)readFile:(NSString *)name Path:(NSString *)path
{
    return [[NSFileManager defaultManager] contentsAtPath:[self filePath:name Path:path]];
}

+ (NSString *)filePath:(NSString *)name Path:(NSString *)path
{
    NSString *resultPath = NSHomeDirectory();
    resultPath = [resultPath stringByAppendingPathComponent:@"Library/Caches"];
    if(path && [path length] != 0)
    {
        resultPath = [resultPath stringByAppendingPathComponent:path];
    }
    if (name && [name length] != 0) {
        resultPath = [resultPath stringByAppendingPathComponent:name];
    }
    return resultPath;
}

@end
