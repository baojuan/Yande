//
//  UIImageView+ImageDownloader.m
//  Yande
//
//  Created by 南 篤良 on 14-1-13.
//  Copyright (c) 2014年 南 篤良. All rights reserved.
//

#import "UIImageView+ImageDownloader.h"
#import "IOManager.h"
#import "ImageCache.h"
#import "NSString+Hashing.h"

@implementation UIImageView (ImageDownloader)

- (void)imageLoadFromUrl:(NSString *)url
{
    NSString *realUrl = [url MD5Hash];
    
    NSData *data = [[ImageCache shareCache]read:realUrl];
    if (data == nil)
    {
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            NSData *fileData = [IOManager readFile:realUrl Path:nil];
            dispatch_async(dispatch_get_main_queue(), ^{
                if (fileData == nil)
                {
                    dispatch_async(dispatch_get_global_queue(0, 0), ^{
                        NSData *downloadData = [NSData dataWithContentsOfURL:[NSURL URLWithString:url]];
                        dispatch_async(dispatch_get_main_queue(), ^{
                            self.image = [UIImage imageWithData:downloadData];
                            CGRect rect = self.frame;
                            rect.size = CGSizeMake(self.image.size.width/2.0, self.image.size.height/2.0);
                            self.frame = rect;
                        });
                        dispatch_async(dispatch_get_global_queue(0, 0), ^{
                            
                            if ([IOManager writeFile:downloadData Name:realUrl Path:nil])
                            {
                                [[ImageCache shareCache]write:downloadData forKey:realUrl];
                            }
                            
                        });
                    });
                }
                else
                {
                    dispatch_async(dispatch_get_global_queue(0, 0), ^{
                        [[ImageCache shareCache]write:fileData forKey:realUrl];
                    });
                    self.image = [UIImage imageWithData:fileData];
                    CGRect rect = self.frame;
                    rect.size = CGSizeMake(self.image.size.width/2.0, self.image.size.height/2.0);
                    self.frame = rect;
                }
            });
        });
        
    }
    else
    {
        self.image = [UIImage imageWithData:data];
        CGRect rect = self.frame;
        rect.size = CGSizeMake(self.image.size.width/2.0, self.image.size.height/2.0);
        self.frame = rect;
    }

}

- (void)imageLoadFromUrl:(NSString *)url ImageID:(NSString *)imageID Type:(NSString *)type
{
    NSData *data = [[ImageCache shareCache]read:imageID Type:type];
    if (data == nil)
    {
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            NSData *fileData = [IOManager readFile:imageID Path:type];
            dispatch_async(dispatch_get_main_queue(), ^{
                if (fileData == nil)
                {
                    dispatch_async(dispatch_get_global_queue(0, 0), ^{
                        NSData *downloadData = [NSData dataWithContentsOfURL:[NSURL URLWithString:url]];
                        dispatch_async(dispatch_get_main_queue(), ^{
                            self.image = [UIImage imageWithData:downloadData];
                            CGRect rect = self.frame;
                            rect.size = CGSizeMake(self.image.size.width/2.0, self.image.size.height/2.0);
                            self.frame = rect;
                        });
                        dispatch_async(dispatch_get_global_queue(0, 0), ^{
                            
                            if ([IOManager writeFile:downloadData Name:imageID Path:type])
                            {
                                [[ImageCache shareCache]write:downloadData forName:imageID Type:type];
                            }
                            
                        });
                    });
                }
                else
                {
                    dispatch_async(dispatch_get_global_queue(0, 0), ^{
                        [[ImageCache shareCache]write:fileData forName:imageID Type:type];
                    });
                    self.image = [UIImage imageWithData:fileData];
                    CGRect rect = self.frame;
                    rect.size = CGSizeMake(self.image.size.width/2.0, self.image.size.height/2.0);
                    self.frame = rect;
                }
            });
        });
        
    }
    else
    {
        self.image = [UIImage imageWithData:data];
        CGRect rect = self.frame;
        rect.size = CGSizeMake(self.image.size.width/2.0, self.image.size.height/2.0);
        self.frame = rect;
    }
}

@end
