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
#import "User.h"


@interface DetailViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *deviceImageView;
@property (weak, nonatomic) IBOutlet UILabel *modelLabel;
@property (weak, nonatomic) IBOutlet UILabel *conditionLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateAddedLabel;
@property (weak, nonatomic) IBOutlet UILabel *locationLabel;
@property (weak, nonatomic) IBOutlet UITextView *descriptionLabel;


@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.modelLabel.text  = self.listing.title;
    self.conditionLabel.text = self.listing.quality;
    if (self.listing.city == NULL || self.listing.state == NULL) {
        self.locationLabel.text = @"";
    }
    else{
         self.locationLabel.text = [NSString stringWithFormat:@"%@,%@", self.listing.city, self.listing.state];
    }
   
    self.dateAddedLabel.text = self.listing[@"createdAt"];
    self.descriptionLabel.text = self.listing[@"description"];
    
    PFFile *imageFile = self.listing.image;
    [imageFile getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
        if (!error) {
            self.deviceImageView.image = [UIImage imageWithData:data];
        }
    }];
    
    // round corners
    self.deviceImageView.clipsToBounds = YES;
    self.deviceImageView.layer.borderColor = [UIColor blackColor].CGColor;
    self.deviceImageView.layer.borderWidth = 2.0;
    self.deviceImageView.layer.cornerRadius = 10.0;
}

- (IBAction)cancelButtonTapped:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}



- (IBAction)itemRequest:(id)sender
{
    NYAlertViewController *alertViewController = [[NYAlertViewController alloc] initWithNibName:nil bundle:nil];
    alertViewController.title = NSLocalizedString(@" Create Item Request", nil);
    alertViewController.message =  @"Remember that more than one person mayrequest this item! Please provide a brief note to the donor on why this is important to you and how this will impact your life...";
    
    alertViewController.titleFont = [UIFont fontWithName:@"AvenirNext-Bold" size:alertViewController.titleFont.pointSize];
    alertViewController.messageFont = [UIFont fontWithName:@"AvenirNext-Regular" size:alertViewController.messageFont.pointSize];
    alertViewController.buttonTitleFont = [UIFont fontWithName:@"AvenirNext-Bold" size:alertViewController.buttonTitleFont.pointSize];
    alertViewController.cancelButtonTitleFont = [UIFont fontWithName:@"AvenirNext-Regular" size:alertViewController.cancelButtonTitleFont.pointSize];
    
    NYAlertAction *submitAction = [NYAlertAction actionWithTitle:NSLocalizedString(@"Submit", nil)
                                                           style:UIAlertActionStyleDefault
                                                         handler:^(NYAlertAction *action) {

                                                             User *user =[User currentUser];
                                                             NSMutableArray * requestsArray = [[NSMutableArray alloc]initWithArray:user.requestedItems];
                                                             [requestsArray addObject:self.listing.title];
                                                             
                                                             user.requestedItems = requestsArray;
                                                             
                                                             
                                                             [user saveInBackground];
                                                            
                                                             
                                                             [self dismissViewControllerAnimated:YES completion:nil];
                                                         }];
    
    alertViewController.alertViewBackgroundColor = [UIColor whiteColor];
    alertViewController.alertViewCornerRadius = 10.0f;
    
    alertViewController.titleColor = [UIColor colorWithRed:0.44f green:0.83f blue:0.60f alpha:1.0f];
    alertViewController.messageColor = [UIColor colorWithRed:0.38f green:0.38f blue:0.38f alpha:1.0f];
    
    alertViewController.buttonColor = [UIColor colorWithRed:0.44f green:0.83f blue:0.60f alpha:1.0f];
    alertViewController.buttonTitleColor = [UIColor whiteColor];
    
    alertViewController.cancelButtonColor = [UIColor lightGrayColor];
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
COMMENT THIS OUT
     
     [alertViewController addTextFieldWithConfigurationHandler:^(UITextField *textField) {
     textField.placeholder = NSLocalizedString(@"Password", nil);
     textField.font = [UIFont fontWithName:@"AvenirNext-Regular" size:16.0f];
     textField.secureTextEntry = YES;
     }];
     
     
     
     */
    [self presentViewController:alertViewController animated:YES completion:nil];
    
    
   
    
}

-(BOOL) textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if(self.alertText.text.length >= 10 && range.length == 0) {
        return NO;
        
    }
    return YES;
}


@end
