//
//  Owner.m
//  SneakrBook
//
//  Created by Kyle Yoon on 10/22/14.
//  Copyright (c) 2014 yoonapps. All rights reserved.
//

#import "Owner.h"
#import "Sneaker.h"


@implementation Owner

@dynamic name;
@dynamic friend;
@dynamic sneakers;

+ (void)retrieveJSONDataWithContext:(NSManagedObjectContext *)context completion:(void(^)(void))completion{
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://s3.amazonaws.com/mobile-makers-assets/app/public/ckeditor_assets/attachments/18/friends.json"]];
    NSLog(@"Loading JSON");
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        NSArray *jsonArray = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        NSLog(@"json is %@", jsonArray);
        for (NSString *name in jsonArray) {
            Owner *owner = [NSEntityDescription insertNewObjectForEntityForName:@"Owner" inManagedObjectContext:context];
            owner.name = name;
            owner.friend = [NSNumber numberWithBool:NO];
        }
        [context save:nil];
    }];
}

- (UIImage *)returnMostCommentedShoeImage {
    if (self.sneakers.count == 0) {
        return [UIImage imageNamed:@"default"];
    }
    Sneaker *mostCommentedSneaker = [self.sneakers anyObject];
    int count = (int)(mostCommentedSneaker.comments.count);
    for (Sneaker *sneaker in self.sneakers) {
        if (sneaker.comments.count > count) {
            count = (int)sneaker.comments.count;
            mostCommentedSneaker = sneaker;
        }
    }
    return [UIImage imageNamed:mostCommentedSneaker.imageName];
}



@end
