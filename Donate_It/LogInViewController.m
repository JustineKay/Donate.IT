//
//  LogInViewController.m
//  Donate_It
//
//  Created by Justine Gartner on 10/31/15.
//  Copyright © 2015 Justine Kay. All rights reserved.
//

#import "LogInViewController.h"
#import "ListingsViewController.h"
#import "User.h"

@interface LogInViewController ()

@property (weak, nonatomic) IBOutlet UILabel *donateItLabel;
@property (weak, nonatomic) IBOutlet UITextField *usernameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;

@end

@implementation LogInViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (IBAction)signUpButtonTapped:(UIButton *)sender {
    
    //show alertViewController
    //user must input username, email, password
    
}
- (IBAction)logInButtonTapped:(UIButton *)sender {
    
    [self saveUsernameWith: self.usernameTextField.text];
    
    [self segueToListingsViewController];
}

-(void)segueToListingsViewController{
    
    ListingsViewController *listingsVC = [self.storyboard instantiateInitialViewController];
    
    [self presentViewController:listingsVC animated:YES completion:nil];
    
}

-(void)saveUsernameWith: (NSString *)newUsername{
    
    NSString *username = newUsername;
    
    [[NSUserDefaults standardUserDefaults] setObject:username forKey:UsernameKey];
}

- (IBAction)forgotUsernamePasswordButtonTapped:(UIButton *)sender {
    
    //do nothing for now
}

@end
