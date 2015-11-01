//
//  LogInViewController.m
//  Donate_It
//
//  Created by Justine Gartner on 10/31/15.
//  Copyright © 2015 Justine Kay. All rights reserved.
//

#import "LogInViewController.h"
#import "ListingsViewController.h"
#import "NYAlertViewController.h"
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
    
    [self presentSignUpWithCallbackBlock:^{
        NSLog(@"completionBlock");
        [self segueToListingsViewController];
    }];
    

    

    
}


-(void) presentSignUpWithCallbackBlock:(void (^)(void))completionBlock{
    
    NYAlertViewController *alertViewController = [[NYAlertViewController alloc] initWithNibName:nil bundle:nil];
    alertViewController.title = NSLocalizedString(@"Create an Account", nil);
    alertViewController.message =  nil;
    
    alertViewController.titleFont = [UIFont fontWithName:@"AvenirNext-Bold" size:alertViewController.titleFont.pointSize];
    alertViewController.messageFont = [UIFont fontWithName:@"AvenirNext-Regular" size:alertViewController.messageFont.pointSize];
    alertViewController.buttonTitleFont = [UIFont fontWithName:@"AvenirNext-Bold" size:alertViewController.buttonTitleFont.pointSize];
    alertViewController.cancelButtonTitleFont = [UIFont fontWithName:@"AvenirNext-Regular" size:alertViewController.cancelButtonTitleFont.pointSize];
    
    NYAlertAction *submitAction = [NYAlertAction actionWithTitle:NSLocalizedString(@"Sign Up!", nil)
                                                           style:UIAlertActionStyleDefault
                                                         handler:^(NYAlertAction *action) {
                                                             
                                                             NSString * name = [[alertViewController.textFields firstObject] text];
                                                             NSString * email = [[alertViewController.textFields objectAtIndex:1] text];
                                                             NSString * password = [[alertViewController.textFields objectAtIndex:2] text];
                                                             
                                                             User *newUser = [User user];
                                                             newUser.username = name;
                                                             newUser.password = password;
                                                             newUser.email = email;

                                                             [newUser signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                                                                 if (!error) {
                                                                     NSLog(@"success!");
                                                                     [self saveUsernameWith:name];
                                                                     completionBlock();
                                                                     
                                                                     
                                                                 } else {
                                                                     NSString *errorString = [error userInfo][@"error"];
                                                                     NSLog(@"%@", errorString);
                                                                 }
                                                             }];
                                                             
                                                             [self dismissViewControllerAnimated:YES completion:nil];
                                                             
                                                         }];
    
    alertViewController.alertViewBackgroundColor = [UIColor colorWithRed:0.09 green:0.66 blue:.09 alpha:1.0];
    alertViewController.alertViewCornerRadius = 10.0f;
    
    alertViewController.titleColor = [UIColor colorWithRed:0.30f green:0.30 blue:0.30f alpha:1.0f];
    alertViewController.messageColor = [UIColor whiteColor];
    
    alertViewController.buttonColor = [UIColor colorWithRed:0.30f green:0.30 blue:0.30f alpha:1.0f];
    alertViewController.buttonTitleColor = [UIColor whiteColor];
    
    alertViewController.cancelButtonColor = [UIColor colorWithRed:0.30f green:0.30 blue:0.30 alpha:1.0f];
    alertViewController.cancelButtonTitleColor = [UIColor whiteColor];
    
    
    
    submitAction.enabled = NO;
    [alertViewController addAction:submitAction];
    
    // Disable the submit action until the user has filled out both text fields
    [[NSNotificationCenter defaultCenter] addObserverForName:UITextFieldTextDidChangeNotification
                                                      object:nil
                                                       queue:[NSOperationQueue mainQueue]
                                                  usingBlock:^(NSNotification *note) {
                                                      UITextField *usernameTextField = [alertViewController.textFields firstObject];
                                                      UITextField *passwordTextField = [alertViewController.textFields lastObject];
                                                      
                                                      submitAction.enabled = ([usernameTextField.text length] && [passwordTextField.text length]);
                                                  }];
    
    [alertViewController addAction:[NYAlertAction actionWithTitle:NSLocalizedString(@"Cancel", nil)
                                                            style:UIAlertActionStyleCancel
                                                          handler:^(NYAlertAction *action) {
                                                              [self dismissViewControllerAnimated:YES completion:nil];
                                                          }]];
    
    [alertViewController addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.placeholder = NSLocalizedString(@"Username", nil);
        textField.font = [UIFont fontWithName:@"AvenirNext-Regular" size:16.0f];
    }];
    
    [alertViewController addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.placeholder = NSLocalizedString(@"Email", nil);
        textField.font = [UIFont fontWithName:@"AvenirNext-Regular" size:16.0f];
    }];
    
    
    [alertViewController addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.placeholder = NSLocalizedString(@"Password", nil);
        textField.font = [UIFont fontWithName:@"AvenirNext-Regular" size:16.0f];
        textField.secureTextEntry = YES;
    }];
    
    
    
    [self presentViewController:alertViewController animated:YES completion:nil];

    
}

- (IBAction)logInButtonTapped:(UIButton *)sender {
    
    [User logInWithUsernameInBackground:self.usernameTextField.text password:self.passwordTextField.text
                                    block:^(PFUser *user, NSError *error) {
                                        if (user) {
                                            NSLog(@"%@", user.username);
                                        } else {
                                            
                                        }
                                    }];
    
    [self saveUsernameWith: self.usernameTextField.text];
    
    [self segueToListingsViewController];
}

-(void)segueToListingsViewController{
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    ListingsViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"ListingsViewController"];

    
    [self presentViewController:vc animated:YES completion:nil];

    
}

-(void)saveUsernameWith: (NSString *)newUsername{
    
    NSString *username = newUsername;
    
    [[NSUserDefaults standardUserDefaults] setObject:username forKey:UsernameKey];
}

- (IBAction)forgotUsernamePasswordButtonTapped:(UIButton *)sender {
    
    //do nothing for now
}

@end
