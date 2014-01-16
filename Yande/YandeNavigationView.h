//
//  YandeNavigationView.h
//  Yande
//
//  Created by 南 篤良 on 14-1-12.
//  Copyright (c) 2014年 南 篤良. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YandeNavigationView : UIView
//标题label
@property (nonatomic,strong)UILabel *titleLabel;
//菜单按钮
@property (nonatomic,strong)UIButton *menuButton;
//设置按钮
@property (nonatomic,strong)UIButton *settingButton;

- (id)initWithDoubleButtonTitle:(NSString *)title MenuButtonIcon:(UIImage *)menuButtonIcon SettingButtonIcon:(UIImage *)settingButtonIcon ButtonDelegate:(id)buttonDelegate MenuButtonSelecter:(SEL)menuButtonSelecter SettingButtonSelecter:(SEL)settingButtonSelecter;

@end
