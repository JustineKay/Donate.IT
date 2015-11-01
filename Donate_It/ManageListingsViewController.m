//
//  ManageListingsViewController.m
//  Donate_It
//
//  Created by Shena Yoshida on 10/31/15.
//  Copyright © 2015 Justine Kay. All rights reserved.
//

#import "ManageListingsViewController.h"
#import "ListingsTableViewCell.h"
#import "NYAlertViewController.h"
#import <Parse/Parse.h>
#import "Listing.h"
#import "User.h"

@interface ManageListingsViewController ()
<
UITableViewDelegate,
UITableViewDataSource
>

@property (nonatomic) NSMutableArray *listingsArray;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation ManageListingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // set up custom cell .xib
    UINib *nib = [UINib nibWithNibName:@"ListingsTableViewCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"listingsIdentifier"];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    self.listingsArray = [[NSMutableArray alloc]init];
    
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 40.0;
    
    
        User *user = [User currentUser];
        PFQuery *query = [PFQuery queryWithClassName:@"Listing"];
        [query whereKey:@"user" equalTo:user];
        [query findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
            [self.listingsArray addObjectsFromArray:objects];
            [self.tableView reloadData];
        }];
    
    
}

#pragma mark - table view data

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section  {
    return self.listingsArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ListingsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"listingsIdentifier" forIndexPath:indexPath];
   
    Listing * listing = [self.listingsArray objectAtIndex:indexPath.row];
    
    cell.listingsModelLabel.text = listing.title;
    cell.listingsConditionLabel.text = listing.quality;
    PFFile *imageFile = listing.image;
    [imageFile getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
        if (!error) {
            cell.listingsImageView.image = [UIImage imageWithData:data];
        }
    }];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [self presentAlertController];
}

-(void)presentAlertController{
    
    NYAlertViewController *alertViewController = [[NYAlertViewController alloc] initWithNibName:nil bundle:nil];
    alertViewController.title = nil;
    alertViewController.message =  nil;
    
    alertViewController.titleFont = [UIFont fontWithName:@"AvenirNext-Bold" size:alertViewController.titleFont.pointSize];
    alertViewController.messageFont = [UIFont fontWithName:@"AvenirNext-Regular" size:alertViewController.messageFont.pointSize];
    alertViewController.buttonTitleFont = [UIFont fontWithName:@"AvenirNext-Regular" size:alertViewController.buttonTitleFont.pointSize];
    alertViewController.cancelButtonTitleFont = [UIFont fontWithName:@"AvenirNext-Medium" size:alertViewController.cancelButtonTitleFont.pointSize];
    
    alertViewController.alertViewBackgroundColor = [UIColor whiteColor];
    alertViewController.alertViewCornerRadius = 10.0f;
    
    alertViewController.titleColor = [UIColor colorWithRed:0.30f green:0.30 blue:0.30f alpha:1.0f];
    alertViewController.messageColor = [UIColor whiteColor];
    
    alertViewController.buttonColor = [UIColor colorWithRed:0.30f green:0.30 blue:0.30f alpha:1.0f];
    alertViewController.buttonTitleColor = [UIColor whiteColor];
    
    alertViewController.cancelButtonColor = [UIColor colorWithRed:0.30f green:0.30 blue:0.30 alpha:1.0f];
    alertViewController.cancelButtonTitleColor = [UIColor whiteColor];
    
    
    
    NYAlertAction *editListing = [NYAlertAction actionWithTitle:NSLocalizedString(@"Edit", nil)
                                                           style:UIAlertActionStyleDefault
                                                         handler:^(NYAlertAction *action) {
                                                             [self dismissViewControllerAnimated:YES completion:nil];
                                                         }];
    NYAlertAction *markListingAsDonated = [NYAlertAction actionWithTitle:NSLocalizedString(@"Mark Donated", nil)
                                                          style:UIAlertActionStyleDefault
                                                        handler:^(NYAlertAction *action) {
                                                            [self dismissViewControllerAnimated:YES completion:nil];
                                                        }];
    
    NYAlertAction *deleteListing = [NYAlertAction actionWithTitle:NSLocalizedString(@"Delete", nil)
                                                          style:UIAlertActionStyleDefault
                                                        handler:^(NYAlertAction *action) {
                                                            [self dismissViewControllerAnimated:YES completion:nil];
                                                        }];
    
    
    NYAlertAction *cancelAction = [NYAlertAction actionWithTitle:NSLocalizedString(@"Cancel", nil)
                                                            style:UIAlertActionStyleCancel
                                                          handler:^(NYAlertAction *action) {
                                                              
                                                              
                                                              [self dismissViewControllerAnimated:YES completion:nil];
                                                          }];
    
    [alertViewController addAction:editListing];
    [alertViewController addAction:markListingAsDonated];
    [alertViewController addAction:deleteListing];
    [alertViewController addAction: cancelAction];
    
    [self presentViewController:alertViewController animated:YES completion:nil];
}


- (IBAction)cancelButtonTapped:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
