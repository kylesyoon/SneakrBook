//
//  Sneaker.h
//  SneakrBook
//
//  Created by Kyle Yoon on 10/22/14.
//  Copyright (c) 2014 yoonapps. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Owner;

@interface Sneaker : NSManagedObject

@property (nonatomic, retain) NSString * brand;
@property (nonatomic, retain) NSString * color;
@property (nonatomic, retain) NSNumber * size;
@property (nonatomic, retain) NSString * imageName;
@property (nonatomic, retain) Owner *owners;
@property (nonatomic, retain) NSSet *comments;
@end

@interface Sneaker (CoreDataGeneratedAccessors)

- (void)addCommentsObject:(NSManagedObject *)value;
- (void)removeCommentsObject:(NSManagedObject *)value;
- (void)addComments:(NSSet *)values;
- (void)removeComments:(NSSet *)values;

@end
