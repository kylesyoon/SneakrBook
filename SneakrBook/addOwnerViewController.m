//
//  addOwnerViewController.m
//  SneakrBook
//
//  Created by Kyle Yoon on 10/22/14.
//  Copyright (c) 2014 yoonapps. All rights reserved.
//

#import "addOwnerViewController.h"

@interface addOwnerViewController ()

@property NSArray *owners;

@end

@implementation addOwnerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadOwners];
    if (self.owners.count == 0)
    {
        [self loadInitialJSON];
    }
}

- (void)loadOwners {
    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:@"Owner"];
    request.sortDescriptors = [NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"Owner" ascending:YES]];
    self.owners = [self.managedObjectContext executeFetchRequest:request error:nil];
    
    [self.tableView reloadData];
}

- (void)loadInitialJSON {
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://s3.amazonaws.com/mobile-makers-assets/app/public/ckeditor_assets/attachments/18/friends.json"]];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        NSArray *jsonArray = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        
        for (NSString *name in jsonArray) {
            Owner *owner = [NSEntityDescription insertNewObjectForEntityForName:@"Owner" inManagedObjectContext:self.managedObjectContext];
            owner.name = name;
        }
        [self.managedObjectContext save:nil];
    }];
    [self loadOwners];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.owners.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    Owner *owner = [self.owners objectAtIndex:indexPath.row];
    
    cell.textLabel.text = owner.name;
    
    return cell;
}

- (void)addOwner {
    Owner *owner = [NSEntityDescription insertNewObjectForEntityForName:@"Owner" inManagedObjectContext:self.managedObjectContext];
    owner = [self.owners objectAtIndex:self.tableView.indexPathForSelectedRow.row];
    [owner setValue:[NSNumber numberWithBool:YES] forKey:@"friend"];
    [self.managedObjectContext save:nil];
}


@end
