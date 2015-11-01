//
//  ListingsTableViewCell.m
//  Donate_It
//
//  Created by Shena Yoshida on 10/31/15.
//  Copyright © 2015 Justine Kay. All rights reserved.
//

#import "ListingsTableViewCell.h"

@implementation ListingsTableViewCell

- (void)awakeFromNib {
    
    
    // R: 113 G: 211 B: 152
    // round corners
    self.listingsImageView.clipsToBounds = YES;
    self.listingsImageView.layer.borderColor = [[UIColor colorWithRed:113.0f/255.0f green:211.0f/255.0f blue:152.0f/255.0f alpha:1.0]CGColor];
    self.listingsImageView.layer.borderWidth = 2.0;
    self.listingsImageView.layer.cornerRadius = 5.0;
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
