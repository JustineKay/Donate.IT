//
//  User.h
//  Donate_It
//
//  Created by Justine Gartner on 10/31/15.
//  Copyright © 2015 Justine Kay. All rights reserved.
//

#import <Parse/Parse.h>
#import "PFUser.h"

@interface User : PFUser<PFSubclassing>

@property (nonatomic) NSMutableArray * itemsToDonate;
@property (nonatomic) NSMutableArray * donatedItems;
@property (nonatomic) NSMutableArray * requestedItems;
@property (nonatomic) NSString * email;

@end
