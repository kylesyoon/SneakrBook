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
    [super viewDidLoad];
    [self loadAddedOwners];
}

- (void)viewDidAppear:(BOOL)animated {
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
    int commentCount = 0;
    for(Sneaker *sneaker in owner.sneakers) {
        commentCount += (int)[[sneaker comments] count];
    }
    
    cell.textLabel.text = owner.name;
    cell.imageView.image = [owner returnMostCommentedShoeImage];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"(%d)", commentCount];
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.friendOwners.count;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"addSegue"]) {
        [[segue destinationViewController] setManagedObjectContext:self.managedObjectContext];
        //Need to pass the managedObjectContext since we are not passing any managed objects.
    } else if ([segue.identifier isEqualToString:@"detailSegue"]) {
        ProfileViewController *detailVC = segue.destinationViewController;
        detailVC.owner = [self.friendOwners objectAtIndex:self.tableView.indexPathForSelectedRow.row];
    }
}

- (IBAction)unwindFromAddOwner:(UIStoryboardSegue *)segue {
    NSLog(@"unwind methods");
    addOwnerViewController *addOwnerVC = segue.sourceViewController;
    [addOwnerVC addOwner];
    [self loadAddedOwners];
}

@end
