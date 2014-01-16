//
//  UIImageView+ImageDownloader.h
//  Yande
//
//  Created by 南 篤良 on 14-1-13.
//  Copyright (c) 2014年 南 篤良. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (ImageDownloader)

- (void)imageLoadFromUrl:(NSString *)url;

- (void)imageLoadFromUrl:(NSString *)url ImageID:(NSString *)imageID Type:(NSString *)type;

@end
