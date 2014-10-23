//
//  AddShoeViewController.h
//  SneakrBook
//
//  Created by Kyle Yoon on 10/22/14.
//  Copyright (c) 2014 yoonapps. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "Sneaker.h"


@interface AddShoeViewController : UIViewController

@property NSManagedObjectContext *managedObjectContext;

- (Sneaker *)createSneaker;

@end
