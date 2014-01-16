//
//  ImageCache.m
//  Yande
//
//  Created by 南 篤良 on 14-1-12.
//  Copyright (c) 2014年 南 篤良. All rights reserved.
//

#import "ImageCache.h"
#import "IOManager.h"
static ImageCache *gl_cache = nil;

@implementation ImageCache

+ (ImageCache *)shareCache
{
    if(!gl_cache)
    {
        gl_cache = [[self alloc]init];
        //缓存容量
        [gl_cache setTotalCostLimit:8 * 1024 * 1024];
        //缓存个数
        [gl_cache setCountLimit:30];
    }
    return gl_cache;
}

//读取缓存
- (NSData *)read:(NSString *)name Type:(NSString *)type
{
    NSString *key = [NSString stringWithFormat:@"%@_%@",type,name];
    if (key == nil)
    {
        return nil;
    }
    NSData *cacheData = [gl_cache objectForKey:key];
    if (cacheData)
        return cacheData;
    else
        return nil;
}

//写入缓存
- (BOOL)write:(NSData *)data forName:(NSString *)name Type:(NSString *)type
{
    NSString *key = [NSString stringWithFormat:@"%@_%@",type,name];
    if(data == nil)
        return false;
    else{
        [gl_cache setObject:data forKey:key];
        return true;
    }
}



- (BOOL)write:(NSData *)data forKey:(NSString *)key
{
    if(data == nil)
        return false;
    else{
        [gl_cache setObject:data forKey:key];
        return true;
    }
}

- (NSData *)read:(NSString *)key
{
    if (key == nil)
    {
        return nil;
    }
    NSData *cacheData = [gl_cache objectForKey:key];
    if (cacheData)
        return cacheData;
    else
        return nil;
}



@end
