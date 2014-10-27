//
//  CommentsTableViewController.m
//  SneakrBook
//
//  Created by Kyle Yoon on 10/22/14.
//  Copyright (c) 2014 yoonapps. All rights reserved.
//

#import "CommentsViewController.h"
#import "Comment.h"

@interface CommentsViewController () <UITableViewDataSource, UITableViewDelegate>

@property NSArray *comments;
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (strong, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation CommentsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadComments];
}

- (void)loadComments {
//    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:@"Comment"];
//    request.sortDescriptors = [NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"date" ascending:NO]];
//    self.comments = [self.sneaker.managedObjectContext executeFetchRequest:request error:nil];
    
    
    NSArray *unsortedArray = [self.sneaker.comments allObjects];
    self.comments = unsortedArray;
    [self.tableView reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
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
    Comment *comment = [NSEntityDescription insertNewObjectForEntityForName:@"Comment" inManagedObjectContext:self.sneaker.managedObjectContext];
    comment.text = self.textField.text;
    comment.date = [NSDate date];
    comment.sneakers = self.sneaker;
    NSLog(@"The sneakers on this comment: %@", comment.sneakers.brand);
    NSLog(@"The comments for this sneaker: %@", self.sneaker.comments);
    [self.sneaker.managedObjectContext save:nil];
    self.textField.text = @"";
    [self loadComments];
}

@end
