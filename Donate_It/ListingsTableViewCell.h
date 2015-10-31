//
//  ListingsTableViewCell.h
//  Donate_It
//
//  Created by Shena Yoshida on 10/31/15.
//  Copyright © 2015 Justine Kay. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ListingsTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *listingsImageView;
@property (weak, nonatomic) IBOutlet UILabel *listingsModelLabel;
@property (weak, nonatomic) IBOutlet UILabel *listingsLocationLabel;
@property (weak, nonatomic) IBOutlet UILabel *listingsConditionLabel;

@end
