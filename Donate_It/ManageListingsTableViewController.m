//
//  ManageListingsTableViewController.m
//  Donate_It
//
//  Created by Shena Yoshida on 10/31/15.
//  Copyright © 2015 Justine Kay. All rights reserved.
//

#import "ManageListingsTableViewController.h"
#import "ListingsTableViewCell.h"

@interface ManageListingsTableViewController ()

@property (nonatomic) NSMutableArray *listingsArray;

@end

@implementation ManageListingsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // set up custom cell .xib
    UINib *nib = [UINib nibWithNibName:@"ListingsTableViewCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"listingsIdentifier"];
    
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 40.0;
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.listingsArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ListingsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"listingsIdentifier" forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}

@end
