//
//  ManageListingsViewController.m
//  Donate_It
//
//  Created by Shena Yoshida on 10/31/15.
//  Copyright © 2015 Justine Kay. All rights reserved.
//

#import "ManageListingsViewController.h"
#import "ListingsTableViewCell.h"
#import <Parse/Parse.h>
#import "Listing.h"

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
    
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 40.0;
    
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
    
    
}

- (IBAction)cancelButtonTapped:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
