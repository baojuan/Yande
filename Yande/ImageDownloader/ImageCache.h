//
//  ImageCache.h
//  Yande
//
//  Created by 南 篤良 on 14-1-12.
//  Copyright (c) 2014年 南 篤良. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ImageCache : NSCache

+ (ImageCache *)shareCache;

- (BOOL)write:(NSData *)data forName:(NSString *)name Type:(NSString *)type;

- (NSData *)read:(NSString *)name Type:(NSString *)type;


- (BOOL)write:(NSData *)data forKey:(NSString *)key;

- (NSData *)read:(NSString *)key;

@end
