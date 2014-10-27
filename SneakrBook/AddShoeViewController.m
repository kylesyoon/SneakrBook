//
//  AddShoeViewController.m
//  SneakrBook
//
//  Created by Kyle Yoon on 10/22/14.
//  Copyright (c) 2014 yoonapps. All rights reserved.
//

#import "AddShoeViewController.h"

@interface AddShoeViewController ()

@property (weak, nonatomic) IBOutlet UITextField *brandTextField;
@property (weak, nonatomic) IBOutlet UITextField *shoeColorTextField;
@property (weak, nonatomic) IBOutlet UITextField *shoeSizeTextField;
@property (weak, nonatomic) IBOutlet UITextField *imageNameTextField;

@end

@implementation AddShoeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (Sneaker *)createSneaker {
    NSLog(@"creating sneaker");
    Sneaker *sneaker = [NSEntityDescription insertNewObjectForEntityForName:@"Sneaker" inManagedObjectContext:self.managedObjectContext];
    sneaker.brand = self.brandTextField.text;
    sneaker.color = self.shoeColorTextField.text;
    sneaker.size = [NSNumber numberWithFloat:[self.shoeSizeTextField.text floatValue]];
    sneaker.imageName = self.imageNameTextField.text;

    return sneaker;
}
//Gets called when the view unwinds. The button is hooked up to IBAction unwind in ProfileViewController.m


@end

