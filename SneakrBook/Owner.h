//
//  Owner.h
//  SneakrBook
//
//  Created by Kyle Yoon on 10/22/14.
//  Copyright (c) 2014 yoonapps. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import <UIKit/UIKit.h>


@class Sneaker;

@interface Owner : NSManagedObject

@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSNumber *friend;
@property (nonatomic, retain) NSSet *sneakers;
@end

@interface Owner (CoreDataGeneratedAccessors)

- (void)addSneakersObject:(Sneaker *)value;
- (void)removeSneakersObject:(Sneaker *)value;
- (void)addSneakers:(NSSet *)values;
- (void)removeSneakers:(NSSet *)values;

+ (void)retrieveJSONDataWithContext:(NSManagedObjectContext *)context completion:(void(^)(void))completion;
- (UIImage *)returnMostCommentedShoeImage;


@end
