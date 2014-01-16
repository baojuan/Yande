//
//  IOManager.h
//  Yande
//
//  Created by 南 篤良 on 14-1-12.
//  Copyright (c) 2014年 南 篤良. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IOManager : NSObject

+ (BOOL)writeFile:(NSData *)data Name:(NSString *)name Path:(NSString *)path;

+ (NSData *)readFile:(NSString *)name Path:(NSString *)path;

@end