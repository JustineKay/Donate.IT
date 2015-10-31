//
//  User.h
//  Donate_It
//
//  Created by Henna Ahmed on 10/31/15.
//  Copyright © 2015 Justine Kay. All rights reserved.
//

#import <Parse/Parse.h>
#import "PFObject.h"

@interface User : PFObject<PFSubclassing>

@property (nonatomic) NSMutableArray * itemsToDonate;
@property (nonatomic) NSMutableArray * donatedItems;
@property (nonatomic) NSMutableArray * requestedItems;
@property (nonatomic) NSString * email;

+ (NSString *)parseClassName;

@end
