//
//  YandeCell.m
//  Yande
//
//  Created by 鲍娟 on 14-1-16.
//  Copyright (c) 2014年 南 篤良. All rights reserved.
//

#import "YandeCell.h"

@implementation YandeCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.thumb = [[UIImageView alloc]initWithFrame:CGRectMake(0, 6, 0, 0)];
        [self.contentView addSubview:self.thumb];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
