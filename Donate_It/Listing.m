//
//  Listing.m
//  Donate_It
//
//  Created by Henna Ahmed on 10/31/15.
//  Copyright © 2015 Justine Kay. All rights reserved.
//

#import "Listing.h"

@implementation Listing

@dynamic title;
@dynamic description;
@dynamic deviceType;
@dynamic quality;
@dynamic image;
@dynamic available;

+ (NSString *)parseClassName{
    
    return @"Listing";
}


@end
