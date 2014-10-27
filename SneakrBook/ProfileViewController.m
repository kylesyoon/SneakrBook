//
//  DetailViewController.m
//  SneakrBook
//
//  Created by Kyle Yoon on 10/22/14.
//  Copyright (c) 2014 yoonapps. All rights reserved.
//

#import "ProfileViewController.h"
#import "AddShoeViewController.h"
#import "CustomCollectionViewCell.h"
#import "CommentsViewController.h"

@interface ProfileViewController () <UICollectionViewDataSource, UICollectionViewDelegate>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property NSMutableArray *friendShoes;

@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.collectionView.allowsMultipleSelection = NO;
    self.navigationItem.title = self.owner.name;
    [self loadShoes];
}

- (void)loadShoes {
    NSLog(@"Loading shoes");
    self.friendShoes = [NSMutableArray array];
    for (Sneaker *sneaker in self.owner.sneakers) {
        [self.friendShoes addObject:sneaker];
    }
    [self.collectionView reloadData];
}

- (IBAction)unwindFromAddShoe:(UIStoryboardSegue *)segue {
    AddShoeViewController *addShoeVC = segue.sourceViewController;
    Sneaker *sneaker = [addShoeVC createSneaker];
    sneaker.owners = self.owner;
    [self.owner.managedObjectContext save:nil];
    [self loadShoes];
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CustomCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    Sneaker *sneaker = [self.friendShoes objectAtIndex:indexPath.item];
    
    cell.imageView.image = [UIImage imageNamed:sneaker.imageName];
    cell.brandLabel.text = sneaker.brand;
    cell.sizeLabel.text = [NSString stringWithFormat:@"%@", sneaker.size];
    cell.colorLabel.text = sneaker.color;
    return cell;
    
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.friendShoes.count;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"commentSegue"]) {
        CommentsViewController *commentsVC = segue.destinationViewController;
        NSIndexPath *index = [self.collectionView.indexPathsForSelectedItems objectAtIndex:0];
        commentsVC.sneaker = [self.friendShoes objectAtIndex:index.row];
        NSLog(@"The brand is: %@", commentsVC.sneaker.brand);
    } else if ([segue.identifier isEqualToString:@"addSegue"]) {
        AddShoeViewController *addShoeViewController = segue.destinationViewController;
        [addShoeViewController setManagedObjectContext:self.owner.managedObjectContext];
    }
}

@end
