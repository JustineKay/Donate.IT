//
//  CreateListingViewController.m
//  Donate_It
//
//  Created by Shena Yoshida on 10/31/15.
//  Copyright © 2015 Justine Kay. All rights reserved.
//

#import "CreateListingViewController.h"
#import "User.h"
#import <mailgun/Mailgun.h>
#import <ParseUI/ParseUI.h>
#import "NYAlertViewController.h"

@interface CreateListingViewController ()
<
UIPickerViewDataSource,
UIPickerViewDelegate,
UIImagePickerControllerDelegate,
UINavigationControllerDelegate,
UITextViewDelegate
>

// text fields
@property (weak, nonatomic) IBOutlet UITextField *listingCityTextLabel;
@property (weak, nonatomic) IBOutlet UITextField *listingStateTextLabel;
@property (weak, nonatomic) IBOutlet UITextField *listingsModelTextLabel;
@property (weak, nonatomic) IBOutlet UITextView *listingsDescriptionTextField;

// pickers
@property (nonatomic) IBOutlet UIPickerView *listingsDeviceTypePicker;
@property (nonatomic) NSArray *pickerDevice;
@property (nonatomic) NSArray *pickerDeviceCondition;

// other things
@property (nonatomic) IBOutlet UIImageView *listingImage;
@property (nonatomic) NSString *deviceType;
@property (nonatomic) NSString *deviceCondition;
@property (nonatomic) UIGestureRecognizer *tapper;

@property (weak, nonatomic) IBOutlet UIButton *addPhotoButton;

@end

@implementation CreateListingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.addPhotoButton.hidden = NO;
    
    self.pickerDevice = @[@"Phone", @"Laptop", @"Tablet"];
    self.pickerDeviceCondition = @[@"Good", @"Fair", @"Poor"];
    
    self.listingsDeviceTypePicker.dataSource = self;
    self.listingsDeviceTypePicker.delegate = self;
    self.deviceType = @"Phone";
    self.deviceCondition = @"Good";
    
    self.tapper = [[UITapGestureRecognizer alloc]
                   initWithTarget:self action:@selector(handleSingleTap:)];
    self.tapper.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:self.tapper];
    
    // text field:
    self.listingsDescriptionTextField.delegate = self;
    NSString *defaultText = @"Describe your item, tell your story and explain who you would like to offer it to.";
    self.listingsDescriptionTextField.text = defaultText;
    
    
  
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    
    if (self.editingListing == YES) {
        
        self.listingCityTextLabel.text = self.listing.city;
        self.listingStateTextLabel.text = self.listing.state;
        self.listingsModelTextLabel.text = self.listing.title;
        self.listingsDescriptionTextField.text = self.listing.description;
        PFFile *imageFile = self.listing.image;
        [imageFile getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
            if (!error) {
                self.listingImage.image = [UIImage imageWithData:data];
            }
        }];
        
        //set self.listingImage.image to PFFile using Parse UI pod
//        PFImageView *imageView = [[PFImageView alloc] init];
//        imageView.image = [UIImage imageNamed:@"..."]; // placeholder image
//        imageView.file = (PFFile *)someObject[@"picture"]; // remote image
//        [imageView loadInBackground];
    }
    
}

- (void)handleSingleTap:(UITapGestureRecognizer *) sender
{
    [self.view endEditing:YES];
}

#pragma mark - text field

- (void)textViewDidBeginEditing:(UITextView *)textView {
    
    if ([self.listingsDescriptionTextField.text isEqualToString:@"Describe your item, tell your story and explain who you would like to offer it to."]){
        self.listingsDescriptionTextField.text = @"";
    }

}

#pragma mark - picker setup

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 2;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    //set number of rows
    if(component== 0)
    {
        return [self.pickerDevice count];
    }
    else
    {
        return [self.pickerDeviceCondition count];
    }
}

- (NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    if(component == 0)
    {
        return [self.pickerDevice objectAtIndex:row];
    }
    else
    {
        return [self.pickerDeviceCondition objectAtIndex:row];
    }
}

// Catpure the picker view selection
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    
    self.deviceType = [self.pickerDevice objectAtIndex:[self.listingsDeviceTypePicker selectedRowInComponent:0]];
    self.deviceCondition = [self.pickerDeviceCondition objectAtIndex:[self.listingsDeviceTypePicker selectedRowInComponent:1]];
    
}

#pragma mark - Image Picker


- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    self.listingImage.image = info[UIImagePickerControllerEditedImage];
    
    //round image corners
    self.listingImage.clipsToBounds = YES;
    self.listingImage.layer.borderColor = [UIColor whiteColor].CGColor;
    self.listingImage.layer.borderWidth = 2.0;
    self.listingImage.layer.cornerRadius = 10.0;
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
    
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}

#pragma mark - buttons

- (IBAction)cameraButtonTapped:(id)sender {
    
    self.addPhotoButton.hidden = YES;
    
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    [self presentViewController:picker animated:YES completion:NULL];
    
}

- (void)alertView:(NYAlertViewController *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
   if (buttonIndex == 0) {
        NSLog(@"Ok Tapped.");
    }
}

- (IBAction)saveButtonTapped:(id)sender {
    
    if([self.listingsModelTextLabel.text isEqualToString:@""] || [self.listingsDescriptionTextField.text isEqualToString:@""] || [self.listingCityTextLabel.text isEqualToString:@""] || [self.listingStateTextLabel.text isEqualToString:@""]){
        
        /*
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Missing Fields"
                                                        message:@"Please fill in all required fields"
                                                       delegate:self
                                              cancelButtonTitle:@"Ok"
                                              otherButtonTitles:nil,nil];
        [alert show];
         */
        
        NYAlertViewController *alertViewController = [[NYAlertViewController alloc] initWithNibName:nil bundle:nil];
        
        alertViewController.backgroundTapDismissalGestureEnabled = YES;
        alertViewController.swipeDismissalGestureEnabled = YES;
        
        alertViewController.title = NSLocalizedString(@"Missing Fields", nil);
        alertViewController.message = NSLocalizedString(@"Please fill in all required fields", nil);
        
        alertViewController.buttonCornerRadius = 20.0f;
        alertViewController.view.tintColor = self.view.tintColor;
        
        alertViewController.titleFont = [UIFont fontWithName:@"AvenirNext-Bold" size:18.0f];
        alertViewController.messageFont = [UIFont fontWithName:@"AvenirNext-Medium" size:16.0f];
        alertViewController.buttonTitleFont = [UIFont fontWithName:@"AvenirNext-Bold" size:alertViewController.buttonTitleFont.pointSize];
        
        alertViewController.alertViewBackgroundColor = [UIColor whiteColor];
        alertViewController.alertViewCornerRadius = 10.0f;
        
        //R: 113 G: 211 B: 152
        alertViewController.titleColor = [UIColor colorWithRed:0.44f green:0.83f blue:0.60f alpha:1.0f];
        alertViewController.messageColor = [UIColor colorWithRed:0.38f green:0.38f blue:0.38f alpha:1.0f];
        
        alertViewController.buttonColor = [UIColor colorWithRed:0.44f green:0.83f blue:0.60f  alpha:1.0f];
        alertViewController.buttonTitleColor = [UIColor whiteColor];
        
        [alertViewController addAction:[NYAlertAction actionWithTitle:NSLocalizedString(@"Ok", nil)
                                                                style:UIAlertActionStyleDefault
                                                              handler:^(NYAlertAction *action) {
                                                                  [self dismissViewControllerAnimated:YES completion:nil];
                                                              }]];

        
        [self presentViewController:alertViewController animated:YES completion:nil];
        
    
        
        
        
    }
    else{
        /*Save Listing to Parse*/
        User *user = [User currentUser];
        Listing *listing = [[Listing alloc] init];
        listing.title = self.listingsModelTextLabel.text;
        listing.description = self.listingsDescriptionTextField.text;
        listing.available = YES;
        listing.deviceType = self.deviceType;
        listing.quality = self.deviceCondition;
        listing.city = self.listingCityTextLabel.text;
        listing.state = self.listingStateTextLabel.text;
        listing[@"user"] = user;
        
        if (self.listingImage.image == nil) {
            
            UIImage *deviceIcon = [UIImage imageNamed:self.deviceType];
            NSData* data = UIImageJPEGRepresentation(deviceIcon, 0.5f);
            PFFile *imageFile = [PFFile fileWithName:@"ListingImage.jpg" data:data];
            [imageFile saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                if (!error) {
                    [listing setObject:imageFile forKey:@"image"];
                    [listing saveInBackground];
                }
                else{
                    NSLog(@" did not upload file ");
                }
            }];

        }else {
            
            NSData* data = UIImageJPEGRepresentation(self.listingImage.image, 0.5f);
            PFFile *imageFile = [PFFile fileWithName:@"ListingImage.jpg" data:data];
            [imageFile saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                if (!error) {
                    [listing setObject:imageFile forKey:@"image"];
                    [listing saveInBackground];
                }
                else{
                    NSLog(@" did not upload file ");
                }
            }];

        }
    
        
        /*Send Thank You Email to Donor*/
        User *currentUser = [User currentUser];
            NSString *name = currentUser.username;
            NSString *email = currentUser.email;
        
        
        
            Mailgun *mailgun = [Mailgun clientWithDomain:@"https://api.mailgun.net/v3/sandbox12d2286a2b8e4282a62fd29501f4dcac.mailgun.org" apiKey:@"key-c45e4d8259b9c753091dbfd05ac130a2"];
            [mailgun sendMessageTo:email
                              from:@"https://api.mailgun.net/v3/sandbox12d2286a2b8e4282a62fd29501f4dcac.mailgun.org"
                           subject:[NSString stringWithFormat:@"Thank you, %@ 💞", name]
                              body:@"Thanks for donating your device. You're awesome ☃"];
        
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    
    
}
- (IBAction)cancelButton:(UIButton *)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}



@end
