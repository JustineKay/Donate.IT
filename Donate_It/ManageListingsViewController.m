//
//  ManageListingsViewController.m
//  Donate_It
//
//  Created by Shena Yoshida on 10/31/15.
//  Copyright © 2015 Justine Kay. All rights reserved.
//

#import "ManageListingsViewController.h"
#import "CreateListingViewController.h"
#import "ListingsTableViewCell.h"
#import "NYAlertViewController.h"
#import <Parse/Parse.h>
#import "Listing.h"
#import "User.h"
#import <mailgun/Mailgun.h>

@interface ManageListingsViewController ()
<
UITableViewDelegate,
UITableViewDataSource
>

@property (nonatomic) NSMutableArray *listingsArray;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIButton *cancelButton;

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
    
    
    self.cancelButton.layer.cornerRadius = 6;
    
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
    
    if (listing.available == NO) {
        
        cell.contentView.alpha = 0.3;

    }
    
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
    
    Listing *selectedListing = self.listingsArray[indexPath.row];
    
    [self presentAlertControllerWith:selectedListing CallbackBlock:^{
        
        [self editListing:selectedListing];
        
    }];
}

-(void)presentAlertControllerWith: (Listing *)selectedListing CallbackBlock:(void (^)(void))completionBlock{
    
    NYAlertViewController *alertViewController = [[NYAlertViewController alloc] initWithNibName:nil bundle:nil];
    alertViewController.title = nil;
    alertViewController.message =  nil;
    
    //alertViewController.titleFont = [UIFont fontWithName:@"AvenirNext-Bold" size:alertViewController.titleFont.pointSize];
    alertViewController.messageFont = [UIFont fontWithName:@"AvenirNext-Regular" size:alertViewController.messageFont.pointSize];
    alertViewController.buttonTitleFont = [UIFont fontWithName:@"AvenirNext-Bold" size:alertViewController.buttonTitleFont.pointSize];
    alertViewController.cancelButtonTitleFont = [UIFont fontWithName:@"AvenirNext-Regular" size:alertViewController.cancelButtonTitleFont.pointSize];
    
    alertViewController.alertViewBackgroundColor = [UIColor whiteColor];
    alertViewController.alertViewCornerRadius = 10.0f;
    
    alertViewController.titleColor = [UIColor colorWithRed:0.44f green:0.83f blue:0.60f alpha:1.0f];
    alertViewController.messageColor = [UIColor colorWithRed:0.38f green:0.38f blue:0.38f alpha:1.0f];
    
    alertViewController.buttonColor = [UIColor colorWithRed:0.44f green:0.83f blue:0.60f alpha:1.0f];
    alertViewController.buttonTitleColor = [UIColor whiteColor];
    
    alertViewController.cancelButtonColor = [UIColor colorWithRed:0.44f green:0.83f blue:0.60f alpha:1.0f ];
    alertViewController.cancelButtonTitleColor = [UIColor whiteColor];
    
    
    
    NYAlertAction *editListing = [NYAlertAction actionWithTitle:NSLocalizedString(@"Edit", nil)
                                                           style:UIAlertActionStyleDefault
                                                         handler:^(NYAlertAction *action) {
                                                             
                                                             
                                                            
                                                             [alertViewController dismissViewControllerAnimated:YES completion:nil];
                                                             
                                                             completionBlock();
                                                             
                                                         }];
    NYAlertAction *markListingAsDonated = [NYAlertAction actionWithTitle:NSLocalizedString(@"Mark Donated", nil)
                                                          style:UIAlertActionStyleDefault
                                                        handler:^(NYAlertAction *action) {
                                                            PFQuery *query = [PFQuery queryWithClassName:@"Listing"];
                                                            [query whereKey:@"createdAt" equalTo:selectedListing.createdAt];
                                                            [query findObjectsInBackgroundWithBlock:^(NSArray *  objects, NSError *  error) {
                                                                if (!error) {
                                                                    
                                                                    Listing *currentListing = [objects firstObject];
                                                                    currentListing.available = NO;
                                                                    [currentListing saveInBackground];
                                                                    
                                                                }
                                                                
                                                            }];
                                                            /*Send Thank You Email to Donor*/
                                                            User *currentUser = [User currentUser];
                                                            NSString *name = currentUser.username;
                                                            NSString *email = currentUser.email;
                                                            
                                                            
                                                            
                                                            Mailgun *mailgun = [Mailgun clientWithDomain:@"https://api.mailgun.net/v3/sandbox12d2286a2b8e4282a62fd29501f4dcac.mailgun.org" apiKey:@"key-c45e4d8259b9c753091dbfd05ac130a2"];
                                                            [mailgun sendMessageTo:email
                                                                              from:@"https://api.mailgun.net/v3/sandbox12d2286a2b8e4282a62fd29501f4dcac.mailgun.org"
                                                                           subject:[NSString stringWithFormat:@"Thank you from Donate.IT, %@ 💞", name]
                                                                              body:@"Thanks so much, you've successfully marked this item as donated. As soon as the recipient marks this item as recieved, you'll recieve your task reciept via email."];

                                                            
                                                            [self dismissViewControllerAnimated:YES completion:nil];
                                                        }];
    
    NYAlertAction *deleteListing = [NYAlertAction actionWithTitle:NSLocalizedString(@"Delete", nil)
                                                          style:UIAlertActionStyleDefault
                                                        handler:^(NYAlertAction *action) {
                                                            
                                                            //delete from parse
                                                            //reload tableView
                                                            
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

-(void)editListing: (Listing *)selectedListing{
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    CreateListingViewController *createListingVC = [storyboard instantiateViewControllerWithIdentifier:@"CreateListingViewController"];
    
    createListingVC.listing = selectedListing;
    createListingVC.editingListing = YES;
    
    [self presentViewController:createListingVC animated:YES completion:nil];
    
}

@end
