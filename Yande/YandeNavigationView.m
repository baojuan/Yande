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

- (id)initWithDoubleButtonTitle:(NSString *)title LeftButtonIcon:(UIImage *)leftButtonIcon RightButtonIcon:(UIImage *)rightButtonIcon ButtonDelegate:(id)buttonDelegate LeftButtonSelecter:(SEL)leftButtonSelecter RightButtonSelecter:(SEL)rightButtonSelecter
{
    self  = [super init];
    if (self)
    {
        //导航栏高
        float navigationHigh = 30;
        //导航栏颜色
        self.backgroundColor = RGBCOLOR(238, 238, 238);
        
        if ([[[UIDevice currentDevice]systemVersion]floatValue] >= 7.0)
            self.frame = CGRectMake(0, 0 , 320, navigationHigh + 20);
        else
            self.frame = CGRectMake(0, 0, 320, navigationHigh);
        //Title
        self.titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, EXTRAIOS7, self.frame.size.width, navigationHigh)];
        self.titleLabel.backgroundColor = [UIColor clearColor];
        self.titleLabel.font = FONT(15);
        self.titleLabel.textColor = [UIColor colorWithRed:250/255.0f green:60/255.0f blue:60/255.0f alpha:1];
        self.titleLabel.text = title;
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:self.titleLabel];
        
        //leftButton
        self.leftButton = [[UIButton alloc]initWithFrame:CGRectMake(6, self.titleLabel.frame.origin.y, leftButtonIcon.size.width, leftButtonIcon.size.height)];
        self.leftButton.adjustsImageWhenDisabled = NO;
        [self.leftButton setImage:leftButtonIcon forState:UIControlStateNormal];
        [self.leftButton addTarget:buttonDelegate action:leftButtonSelecter forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.leftButton];
        
        //rightButton
        self.rightButton = [[UIButton alloc]initWithFrame:CGRectMake(320 - 6 - rightButtonIcon.size.width, self.titleLabel.frame.origin.y, rightButtonIcon.size.width, rightButtonIcon.size.height)];
        self.leftButton.adjustsImageWhenDisabled = NO;
        [self.rightButton setImage:rightButtonIcon forState:UIControlStateNormal];
        [self.rightButton addTarget:buttonDelegate action:rightButtonSelecter forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.rightButton];
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
