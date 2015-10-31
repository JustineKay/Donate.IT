//
//  ListingsViewController.m
//  Donate_It
//
//  Created by Shena Yoshida on 10/31/15.
//  Copyright © 2015 Justine Kay. All rights reserved.
//

#import "ListingsViewController.h"

@interface ListingsViewController ()
<
UITableViewDataSource,
UITabBarDelegate
>

@property (nonatomic) NSArray *testItem;

@end

@implementation ListingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.testItem = @[
                 @"iPhone 5",
                 @"iPhone 4",
                 @"iPhone 5s"
                 ];
   
}

#pragma mark - table view data

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section  {
    return self.testItem.count;
}

// reuse identifier title: listingCellIdentifier

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"listingCellIdentifier" forIndexPath:indexPath];
    cell.textLabel.text = self.testItem[indexPath.row];
    return cell;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
