//
//  Sneaker.h
//  SneakrBook
//
//  Created by Kyle Yoon on 10/22/14.
//  Copyright (c) 2014 yoonapps. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Sneaker : NSManagedObject

@property (nonatomic, retain) NSString *brand;
@property (nonatomic, retain) NSString *color;
@property (nonatomic, retain) NSNumber *size;
@property (nonatomic, retain) NSSet *owners;
@end

@interface Sneaker (CoreDataGeneratedAccessors)

- (void)addOwnersObject:(NSManagedObject *)value;
- (void)removeOwnersObject:(NSManagedObject *)value;
- (void)addOwners:(NSSet *)values;
- (void)removeOwners:(NSSet *)values;

@end
