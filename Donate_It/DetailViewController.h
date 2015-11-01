//
//  DetailViewController.h
//  Donate_It
//
//  Created by Shena Yoshida on 10/31/15.
//  Copyright © 2015 Justine Kay. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Listing.h"

@interface DetailViewController : UIViewController <UITextFieldDelegate>

@property (strong,nonatomic)  UITextField *alertText;


@property (nonatomic) Listing *listing;

@end
