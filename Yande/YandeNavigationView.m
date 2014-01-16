//
//  YandeNavigationView.m
//  Yande
//
//  Created by 南 篤良 on 14-1-12.
//  Copyright (c) 2014年 南 篤良. All rights reserved.
//

#import "YandeNavigationView.h"

@implementation YandeNavigationView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (id)initWithDoubleButtonTitle:(NSString *)title MenuButtonIcon:(UIImage *)menuButtonIcon SettingButtonIcon:(UIImage *)settingButtonIcon ButtonDelegate:(id)buttonDelegate MenuButtonSelecter:(SEL)menuButtonSelecter SettingButtonSelecter:(SEL)settingButtonSelecter
{
    self  = [super init];
    if (self)
    {
        //Title
        //self.backgroundColor = [UIColor redColor];
        self.frame = CGRectMake(0, 0 + EXTRAIOS7, 320, 44);
        self.titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        self.titleLabel.backgroundColor = [UIColor clearColor];
        self.titleLabel.font = [UIFont fontWithName:@"Heiti SC" size:15];
        self.titleLabel.textColor = [UIColor colorWithRed:250/255.0f green:60/255.0f blue:60/255.0f alpha:1];
        self.titleLabel.text = title;
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:self.titleLabel];
        //Button
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
