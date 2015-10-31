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


@interface ListingsViewController ()
<
UITableViewDataSource,
UITableViewDelegate,
UITabBarDelegate
>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic) NSMutableArray *listingsArray;


@end

@implementation ListingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // set up custom cell .xib
    UINib *nib = [UINib nibWithNibName:@"ListingsTableViewCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"listingsIdentifier"];
    
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 35.0;

    
    //fetch parse data
    self.listingsArray = [[NSMutableArray alloc] init];
   
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

-(void) viewWillAppear:(BOOL)animated{
    
    NSLog(@"YAS");
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


- (IBAction)donateItButtonTapped:(UIButton *)sender {
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    CreateListingViewController *createListingVC = [storyboard instantiateViewControllerWithIdentifier:@"CreateListingViewController"];
    
    [self presentViewController:createListingVC animated:YES completion:nil];
    
}


@end
