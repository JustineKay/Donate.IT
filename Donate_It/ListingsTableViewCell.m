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
    
    // round corners
    self.listingsImageView.clipsToBounds = YES;
    self.listingsImageView.layer.borderColor = [UIColor blackColor].CGColor;
    self.listingsImageView.layer.borderWidth = 2.0;
    self.listingsImageView.layer.cornerRadius = 5.0;
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
