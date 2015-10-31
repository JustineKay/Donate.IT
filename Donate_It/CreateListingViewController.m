//
//  CreateListingViewController.m
//  Donate_It
//
//  Created by Shena Yoshida on 10/31/15.
//  Copyright © 2015 Justine Kay. All rights reserved.
//

#import "CreateListingViewController.h"

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
    
}
- (IBAction)cancelButton:(UIButton *)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
