//
//  CreateListingViewController.h
//  Donate_It
//
//  Created by Shena Yoshida on 10/31/15.
//  Copyright © 2015 Justine Kay. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Listing.h"

@interface CreateListingViewController : UIViewController

@property (nonatomic) Listing *listing;
@property (nonatomic) BOOL editingListing;

@end
