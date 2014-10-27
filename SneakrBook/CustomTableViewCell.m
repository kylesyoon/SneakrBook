//
//  CustomTableViewCell.m
//  SneakrBook
//
//  Created by Kyle Yoon on 10/26/14.
//  Copyright (c) 2014 yoonapps. All rights reserved.
//

#import "CustomTableViewCell.h"

@implementation CustomTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.textLabel.frame = CGRectMake(88, 0, self.frame.size.width - 88, 44);

    self.imageView.frame = CGRectMake(0, 0, 88, 44);
    [self.imageView setContentMode:UIViewContentModeScaleAspectFit];
    [self.imageView setClipsToBounds:YES];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
