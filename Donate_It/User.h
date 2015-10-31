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

@property (nonatomic) NSString *objectID;
@property (nonatomic) NSString * title;
@property (nonatomic) NSString * description;
@property (nonatomic) BOOL available;
@property (nonatomic) NSString * deviceType;
@property (nonatomic) NSString * quality;
@property (nonatomic) PFFile *image;
@property (nonatomic) NSDate * createdAt;


@end
