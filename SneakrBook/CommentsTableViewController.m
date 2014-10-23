//
//  CommentsTableViewController.m
//  SneakrBook
//
//  Created by Kyle Yoon on 10/22/14.
//  Copyright (c) 2014 yoonapps. All rights reserved.
//

#import "CommentsTableViewController.h"
#import "Comment.h"

@interface CommentsTableViewController () <UITableViewDataSource>

@property NSArray *comments;
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (strong, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation CommentsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadComments];

}

- (void)loadComments {
    NSArray *unsortedComments = [NSArray arrayWithArray:[self.sneaker.comments allObjects]];
//    NSSortDescriptor *sort = [[NSSortDescriptor alloc] initWithKey:@"date" ascending:YES];
//    NSArray *sortArray = [NSArray arrayWithObject:sort];
//    self.comments = [unsortedComments sortedArrayUsingDescriptors:sortArray];
    self.comments = unsortedComments;
    [self.tableView reloadData];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return self.comments.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    Comment *comment = [self.comments objectAtIndex:indexPath.row];
    
    NSDate *date = comment.date;
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd 'at' HH:mm"];
    NSString *formattedDateString = [dateFormatter stringFromDate:date];
    
    cell.textLabel.text = comment.text;
    cell.detailTextLabel.text = formattedDateString;
    
    return cell;
}

- (IBAction)saveComment:(id)sender {
    Comment *comment = [NSEntityDescription insertNewObjectForEntityForName:@"Comment" inManagedObjectContext:self.managedObjectContext];
    comment.text = self.textField.text;
    NSLog(@"%@", comment.text);
    comment.date = [NSDate date];
    comment.sneakers = self.sneaker;
    [self.managedObjectContext save:nil];
    self.textField.text = @"";
    [self loadComments];
}

@end
