//
//  DetailViewController.h
//  SneakrBook
//
//  Created by Kyle Yoon on 10/22/14.
//  Copyright (c) 2014 yoonapps. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Owner.h"
#import "Sneaker.h"

@interface ProfileViewController : UIViewController

@property NSManagedObjectContext *managedObjectContext;
@property Owner *owner;

@end

