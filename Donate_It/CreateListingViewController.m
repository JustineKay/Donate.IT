//
//  CreateListingViewController.m
//  Donate_It
//
//  Created by Shena Yoshida on 10/31/15.
//  Copyright © 2015 Justine Kay. All rights reserved.
//

#import "CreateListingViewController.h"
#import <mailgun/Mailgun.h>
#import "Listing.h"
#import "User.h"

@interface CreateListingViewController ()
<
UIPickerViewDataSource,
UIPickerViewDelegate,
UIImagePickerControllerDelegate,
UINavigationControllerDelegate
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

@end

@implementation CreateListingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
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

}

- (void)handleSingleTap:(UITapGestureRecognizer *) sender
{
    [self.view endEditing:YES];
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
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}

#pragma mark - buttons

- (IBAction)cameraButtonTapped:(id)sender {
    
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    [self presentViewController:picker animated:YES completion:NULL];
    
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0) {
        NSLog(@"Cancel Tapped.");
    }
}

- (IBAction)saveButtonTapped:(id)sender {
    
    if([self.listingsModelTextLabel.text isEqualToString:@""] || [self.listingsDescriptionTextField.text isEqualToString:@""] || [self.listingCityTextLabel.text isEqualToString:@""] || [self.listingStateTextLabel.text isEqualToString:@""]){
        
        
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Missing Fields"
                                                        message:@"Please fill in all required fields"
                                                       delegate:self
                                              cancelButtonTitle:@"Cancel"
                                              otherButtonTitles:nil,nil];
        [alert show];
    
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
    listing[@"user"] = user;
    
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
    
    


    
        /*Send Thank You Email to Donor*/
        //    NSString *name = @"Henna";
        //    NSString *email = @"henna.ahmed92@gmail.com";
        //    
        //    
        //    
        //    Mailgun *mailgun = [Mailgun clientWithDomain:@"https://api.mailgun.net/v3/sandbox12d2286a2b8e4282a62fd29501f4dcac.mailgun.org" apiKey:@"key-c45e4d8259b9c753091dbfd05ac130a2"];
        //    [mailgun sendMessageTo:email
        //                      from:@"https://api.mailgun.net/v3/sandbox12d2286a2b8e4282a62fd29501f4dcac.mailgun.org"
        //                   subject:[NSString stringWithFormat:@"Thank you, %@ 💞", name]
        //                      body:@"Thanks for donating your device. You're awesome ☃"];
    
    [self dismissViewControllerAnimated:YES completion:nil];
    }
    
    
}
- (IBAction)cancelButton:(UIButton *)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}



@end
