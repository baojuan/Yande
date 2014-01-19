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
@property (nonatomic,strong)UIButton *leftButton;
//设置按钮
@property (nonatomic,strong)UIButton *rightButton;

- (id)initWithDoubleButtonTitle:(NSString *)title LeftButtonIcon:(UIImage *)leftButtonIcon RightButtonIcon:(UIImage *)rightButtonIcon ButtonDelegate:(id)buttonDelegate LeftButtonSelecter:(SEL)leftButtonSelecter RightButtonSelecter:(SEL)rightButtonSelecter;

@end
