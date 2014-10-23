//
//  MasterViewController.m
//  SneakrBook
//
//  Created by Kyle Yoon on 10/22/14.
//  Copyright (c) 2014 yoonapps. All rights reserved.
//

#import "MasterViewController.h"
#import "DetailViewController.h"
#import "Owner.h"
#import "addOwnerViewController.h"

@interface MasterViewController ()

@property NSArray *addedOwners;

@end

@implementation MasterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadAddedOwners];
}

- (void)loadAddedOwners {
    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:@"Owner"];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"friend = 1"];
    request.predicate = predicate;
    self.addedOwners = [self.managedObjectContext executeFetchRequest:request error:nil];
    [self.tableView reloadData];
}


#pragma mark - tableview

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    Owner *owner = [self.addedOwners objectAtIndex:indexPath.row];

    cell.textLabel.text = owner.name;

    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.addedOwners.count;
}

//- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
//    if ([segue.identifier isEqualToString:@"addSegue"]) {
//        [[segue destinationViewController] setManagedObjectContext:self.managedObjectContext];
//    }
//}

- (IBAction)unwindFromAddOwner:(UIStoryboardSegue *)segue {
    [self loadAddedOwners];
}

@end
