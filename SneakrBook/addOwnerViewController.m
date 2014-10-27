//
//  addOwnerViewController.m
//  SneakrBook
//
//  Created by Kyle Yoon on 10/22/14.
//  Copyright (c) 2014 yoonapps. All rights reserved.
//

#import "addOwnerViewController.h"

@interface addOwnerViewController () <UITableViewDataSource>

@property NSArray *owners;

@end

@implementation addOwnerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadOwners];
    if (self.owners.count == 0)
    {
        [self loadInitialJSON];
        NSLog(@"Getting data from JSON");
    }
}

- (void)loadOwners {
    NSLog(@"Fetching");
    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:@"Owner"];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"friend = 0"];
    request.predicate = predicate;
    request.sortDescriptors = [NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES]];
    self.owners = [self.managedObjectContext executeFetchRequest:request error:nil];
    
    [self.tableView reloadData];
}

- (void)loadInitialJSON {
    [Owner retrieveJSONDataWithContext:self.managedObjectContext completion:^{
        [self loadOwners];
    }];
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
    Owner *owner = [self.owners objectAtIndex:self.tableView.indexPathForSelectedRow.row];
    [owner setValue:[NSNumber numberWithBool:YES] forKey:@"friend"];
    NSLog(@"addOwner method, %@", [owner valueForKey:@"friend"]);
    [self.managedObjectContext save:nil];
}


@end
