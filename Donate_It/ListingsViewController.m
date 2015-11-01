//
//  ListingsViewController.m
//  Donate_It
//
//  Created by Shena Yoshida on 10/31/15.
//  Copyright © 2015 Justine Kay. All rights reserved.
//

#import "ListingsViewController.h"
#import "CreateListingViewController.h"
#import "ListingsTableViewCell.h"
#import <Parse/Parse.h>
#import "Listing.h"
#import "DetailViewController.h"
#import "ManageListingsViewController.h"
#import "User.h"
#import <MNFloatingActionButton/MNFloatingActionButton.h>


@interface ListingsViewController ()
<
UITableViewDataSource,
UITableViewDelegate,
UITabBarDelegate
>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic) NSMutableArray *listingsArray;

@property (nonatomic) MNFloatingActionButton *menuButton;
@property (nonatomic) MNFloatingActionButton *requestButton;
@property (nonatomic) MNFloatingActionButton *listingButton;
@property (nonatomic) MNFloatingActionButton *donateButton;
@property (nonatomic) BOOL menuShown;


@end

@implementation ListingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //setup menu
    [self setUpMenu];
    
    // set up custom cell .xib
    UINib *nib = [UINib nibWithNibName:@"ListingsTableViewCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"listingsIdentifier"];
    
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 40.0;

    //fetch parse data
    self.listingsArray = [[NSMutableArray alloc] init];

    [self fetchParseQuery];


}

- (void) setUpMenu{

    self.menuShown = NO;
    CGRect menuFrame = CGRectMake(10, 20, 44, 44);
    CGRect requestFrame = CGRectMake(10, 70, 44, 44);
    CGRect listingFrame = CGRectMake(10, 120, 44, 44);
    CGRect addItem = CGRectMake(10, 170, 44, 44);
    
    
    self.menuButton = [[MNFloatingActionButton alloc] initWithFrame:menuFrame];
    self.menuButton.centerImageView.image = [UIImage imageNamed:@"menu"];
    self.menuButton.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:self.menuButton];
    
    [self.menuButton addTarget:self action:@selector(menuButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    self.requestButton = [[MNFloatingActionButton alloc] initWithFrame:requestFrame];
    self.requestButton.centerImageView.image = [UIImage imageNamed:@"requests"];
    self.requestButton.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:self.requestButton];
    self.requestButton.hidden = YES;
    
    self.listingButton = [[MNFloatingActionButton alloc] initWithFrame:listingFrame];
    self.listingButton.centerImageView.image = [UIImage imageNamed:@"listings"];
    self.listingButton.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:self.listingButton];
    [self.listingButton addTarget:self action:@selector(myItemsButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
    self.listingButton.hidden = YES;
    
    
    self.donateButton = [[MNFloatingActionButton alloc] initWithFrame:addItem];
    self.donateButton.centerImageView.image = [UIImage imageNamed:@"donate"];
    self.donateButton.backgroundColor = [UIColor lightGrayColor];
    [self.donateButton addTarget:self action:@selector(donateItButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.donateButton];
    self.donateButton.hidden = YES;
}

- (void) menuButtonPressed: (id) selector{
    if (self.menuShown) {
        self.requestButton.hidden = YES;
        self.listingButton.hidden = YES;
        self.donateButton.hidden = YES;
        self.menuShown = NO;
    }
    else{
        self.requestButton.hidden = NO;
        self.listingButton.hidden = NO;
        self.donateButton.hidden = NO;
        self.menuShown = YES;
        
    }
    
}

-(void)fetchParseQuery{
    
    [self.listingsArray removeAllObjects];
    
    PFQuery *query = [PFQuery queryWithClassName:@"Listing"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *  objects, NSError *  error) {
        if (!error) {
            
            for(Listing *listing in objects){
                [self.listingsArray addObject: listing];
                [self.tableView reloadData];
            }
            
            
            
        }
        
    }];
}

- (void)viewDidAppear:(BOOL)animated{
[self fetchParseQuery];
}


#pragma mark - table view data

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section  {
    return self.listingsArray.count;
}

// reuse identifier title: listingCellIdentifier

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ListingsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"listingsIdentifier" forIndexPath:indexPath];
    Listing * listing = [self.listingsArray objectAtIndex:indexPath.row];
    
    cell.listingsModelLabel.text = listing.title;
    cell.listingsConditionLabel.text = listing.quality;
    
    if (listing.city == NULL || listing.state == NULL) {
        cell.listingsLocationLabel.text = @"";
    }
    else{
        cell.listingsLocationLabel.text = [NSString stringWithFormat:@"%@,%@", listing.city, listing.state];
    }

    PFFile *imageFile = listing.image;
    [imageFile getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
        if (!error) {
            cell.listingsImageView.image = [UIImage imageWithData:data];
        }
    }];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    DetailViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"ListingDetailVC"];
    vc.listing = [self.listingsArray objectAtIndex:indexPath.row];
    
    [self presentViewController:vc animated:YES completion:nil];

}


- (void)donateItButtonTapped:(id)sender {
    
    self.requestButton.hidden = YES;
    self.listingButton.hidden = YES;
    self.donateButton.hidden = YES;
    self.menuShown = NO;
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    CreateListingViewController *createListingVC = [storyboard instantiateViewControllerWithIdentifier:@"CreateListingViewController"];
    
    createListingVC.editingListing = NO;
    
    [self presentViewController:createListingVC animated:YES completion:nil];
    
}

- (void)myItemsButtonTapped:(id)sender {
    self.requestButton.hidden = YES;
    self.listingButton.hidden = YES;
    self.donateButton.hidden = YES;
    self.menuShown = NO;
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    ManageListingsViewController *manageListingVC = [storyboard instantiateViewControllerWithIdentifier:@"manageListings"];
    
    [self presentViewController:manageListingVC animated:YES completion:nil];
    
}


@end
