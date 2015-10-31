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
    
    self.pickerDeviceData = @[ @[@"iPhone", @"Laptop", @"Tablet"], @[@"good", @"fair", @"poor"]];
    
    self.listingsDeviceTypePicker.dataSource = self;
    self.listingsDeviceTypePicker.delegate = self;

    

}

#pragma mark - picker setup

// The number of columns of data
- (int)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 2;
}

// The number of rows of data
- (int)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return self.pickerDeviceData.count;
}

// The data to return for the row and component (column) that's being passed in
- (NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return self.pickerDeviceData[component][row];
}

#pragma mark - buttons

- (IBAction)cameraButtonTapped:(id)sender {
}

- (IBAction)saveButtonTapped:(id)sender {
}

@end
