//
//  CommentsTableViewController.h
//  SneakrBook
//
//  Created by Kyle Yoon on 10/22/14.
//  Copyright (c) 2014 yoonapps. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Sneaker.h"
#import <CoreData/CoreData.h>

@interface CommentsTableViewController : UITableViewController

@property Sneaker *sneaker;
@property NSManagedObjectContext *managedObjectContext;

@end
