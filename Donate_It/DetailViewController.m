//
//  DetailViewController.m
//  Donate_It
//
//  Created by Shena Yoshida on 10/31/15.
//  Copyright © 2015 Justine Kay. All rights reserved.
//

#import "DetailViewController.h"
#import "NYAlertViewController.h"
#import <Parse/Parse.h>

@interface DetailViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *deviceImageView;

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    PFFile *imageFile = self.listing.image;
    [imageFile getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
        if (!error) {
            self.deviceImageView.image = [UIImage imageWithData:data];
        }
    }];
    
}

- (IBAction)cancelButtonTapped:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}



- (IBAction)itemRequest:(id)sender
{
    NYAlertViewController *alertViewController = [[NYAlertViewController alloc] initWithNibName:nil bundle:nil];
    alertViewController.title = NSLocalizedString(@" Create Item Request", nil);
    alertViewController.message =  nil;
    
    alertViewController.titleFont = [UIFont fontWithName:@"AvenirNext-Bold" size:alertViewController.titleFont.pointSize];
    alertViewController.messageFont = [UIFont fontWithName:@"AvenirNext-Regular" size:alertViewController.messageFont.pointSize];
    alertViewController.buttonTitleFont = [UIFont fontWithName:@"AvenirNext-Regular" size:alertViewController.buttonTitleFont.pointSize];
    alertViewController.cancelButtonTitleFont = [UIFont fontWithName:@"AvenirNext-Medium" size:alertViewController.cancelButtonTitleFont.pointSize];
    
    NYAlertAction *submitAction = [NYAlertAction actionWithTitle:NSLocalizedString(@"Submit", nil)
                                                           style:UIAlertActionStyleDefault
                                                         handler:^(NYAlertAction *action) {
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
        textField.placeholder = NSLocalizedString(@"Name", nil);
        textField.font = [UIFont fontWithName:@"AvenirNext-Regular" size:16.0f];
    }];
    
    [alertViewController addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.placeholder = NSLocalizedString(@"Email", nil);
        textField.font = [UIFont fontWithName:@"AvenirNext-Regular" size:16.0f];
    }];
    [alertViewController addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.placeholder = NSLocalizedString(@"How will this be helpful to you?", nil);
        textField.font = [UIFont fontWithName:@"AvenirNext-Regular" size:16.0f];
        
    }];
    /*
     
     [alertViewController addTextFieldWithConfigurationHandler:^(UITextField *textField) {
     textField.placeholder = NSLocalizedString(@"Password", nil);
     textField.font = [UIFont fontWithName:@"AvenirNext-Regular" size:16.0f];
     textField.secureTextEntry = YES;
     }];
     
     */
    
    [self presentViewController:alertViewController animated:YES completion:nil];
    
}



@end
