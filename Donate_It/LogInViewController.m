//
//  LogInViewController.m
//  Donate_It
//
//  Created by Justine Gartner on 10/31/15.
//  Copyright © 2015 Justine Kay. All rights reserved.
//

#import "LogInViewController.h"
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
}

-(void)saveUsernameWith: (NSString *)newUsername{
    
    //create a string with the Learner's skill.skillName
    NSString *username = newUsername;
    
    //store the string in NSUserDefaults with the key: self.learnerName
    [[NSUserDefaults standardUserDefaults] setObject:username forKey:UsernameKey];
}

- (IBAction)forgotUsernamePasswordButtonTapped:(UIButton *)sender {
    
    //do nothing for now
}

@end
