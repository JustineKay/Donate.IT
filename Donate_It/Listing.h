//
//  Listing.h
//  Donate_It
//
//  Created by Henna Ahmed on 10/31/15.
//  Copyright © 2015 Justine Kay. All rights reserved.
//

#import <Parse/Parse.h>

@interface Listing : PFObject<PFSubclassing>

@property (nonatomic) NSString * title;
@property (nonatomic) NSString * description;
@property (nonatomic) NSString * deviceType;
@property (nonatomic) NSString * quality;
@property (nonatomic) NSString *city;
@property (nonatomic) NSString *state;
@property (nonatomic) PFFile *image;
@property (nonatomic) BOOL available;

+ (NSString *)parseClassName;

@end
