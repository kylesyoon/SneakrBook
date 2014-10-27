//
//  addOwnerViewController.h
//  SneakrBook
//
//  Created by Kyle Yoon on 10/22/14.
//  Copyright (c) 2014 yoonapps. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Owner.h"

@interface addOwnerViewController : UITableViewController

@property NSManagedObjectContext *managedObjectContext;

- (void)addOwner;

@end
