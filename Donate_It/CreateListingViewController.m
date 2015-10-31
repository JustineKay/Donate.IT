//
//  CreateListingViewController.m
//  Donate_It
//
//  Created by Shena Yoshida on 10/31/15.
//  Copyright © 2015 Justine Kay. All rights reserved.
//

#import "CreateListingViewController.h"
#import <mailgun/Mailgun.h>

@interface CreateListingViewController ()
<
UIPickerViewDataSource,
UIPickerViewDelegate
>

// text fields
@property (weak, nonatomic) IBOutlet UITextField *listingCityTextLabel;
@property (weak, nonatomic) IBOutlet UITextField *listingStateTextLabel;
@property (weak, nonatomic) IBOutlet UITextField *listingsModelTextLabel;
@property (weak, nonatomic) IBOutlet UITextView *listingsDescriptionTextField;

// pickers
@property (nonatomic) IBOutlet UIPickerView *listingsDeviceTypePicker;
@property (nonatomic) NSArray *pickerDeviceData;

// other things
@property (nonatomic) IBOutlet UIImageView *listingImage;

@end

@implementation CreateListingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.pickerDeviceData = @[ @[@"Phone", @"Laptop", @"Tablet"], @[@"Good", @"Fair", @"Poor"]];
    
    self.listingsDeviceTypePicker.dataSource = self;
    self.listingsDeviceTypePicker.delegate = self;

}

#pragma mark - picker setup

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 2;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return self.pickerDeviceData.count;
}

- (NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return self.pickerDeviceData[component][row];
}

// Catpure the picker view selection
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    // This method is triggered whenever the user makes a change to the picker selection.
    // The parameter named row and component represents what was selected.
}

#pragma mark - buttons

- (IBAction)cameraButtonTapped:(id)sender {
}

- (IBAction)saveButtonTapped:(id)sender {
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
- (IBAction)cancelButton:(UIButton *)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
