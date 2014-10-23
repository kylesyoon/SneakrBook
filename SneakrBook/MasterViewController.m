//
//  MasterViewController.m
//  SneakrBook
//
//  Created by Kyle Yoon on 10/22/14.
//  Copyright (c) 2014 yoonapps. All rights reserved.
//

#import "MasterViewController.h"
#import "ProfileViewController.h"
#import "Owner.h"
#import "addOwnerViewController.h"

@interface MasterViewController ()

@property NSArray *friendOwners;

@end

@implementation MasterViewController

- (void)viewDidLoad {
    self.navigationItem.leftBarButtonItem = self.editButtonItem;
    
    [super viewDidLoad];
    [self loadAddedOwners];
}

- (void)loadAddedOwners {
    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:@"Owner"];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"friend = 1"];
    request.predicate = predicate;
    self.friendOwners = [self.managedObjectContext executeFetchRequest:request error:nil];
    [self.tableView reloadData];
}


#pragma mark - tableview

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    Owner *owner = [self.friendOwners objectAtIndex:indexPath.row];

    cell.textLabel.text = owner.name;

    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.friendOwners.count;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    [[segue destinationViewController] setManagedObjectContext:self.managedObjectContext];
    if ([segue.identifier isEqualToString:@"addSegue"]) {
        [[segue destinationViewController] setManagedObjectContext:self.managedObjectContext];
    } else if ([segue.identifier isEqualToString:@"detailSegue"]) {
        NSLog(@"Preparing profile segue");
        ProfileViewController *detailVC = segue.destinationViewController;
        detailVC.owner = [self.friendOwners objectAtIndex:self.tableView.indexPathForSelectedRow.row];

    }
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        Owner *owner = [self.friendOwners objectAtIndex:indexPath.row];
        [owner setValue:[NSNumber numberWithBool:NO] forKey:@"friend"];
    }
}




- (IBAction)unwindFromAddOwner:(UIStoryboardSegue *)segue {
    NSLog(@"unwind methods");
    addOwnerViewController *addOwnerVC = segue.sourceViewController;
    [addOwnerVC addOwner];
    [self loadAddedOwners];
}

@end
