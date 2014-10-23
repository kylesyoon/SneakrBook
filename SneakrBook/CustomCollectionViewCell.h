//
//  CustomCollectionViewCell.h
//  SneakrBook
//
//  Created by Kyle Yoon on 10/22/14.
//  Copyright (c) 2014 yoonapps. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UILabel *brandLabel;
@property (weak, nonatomic) IBOutlet UILabel *sizeLabel;
@property (weak, nonatomic) IBOutlet UILabel *colorLabel;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end
