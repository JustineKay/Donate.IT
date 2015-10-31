//
//  User.m
//  Donate_It
//
//  Created by Henna Ahmed on 10/31/15.
//  Copyright © 2015 Justine Kay. All rights reserved.
//

#import "User.h"

@implementation User

@dynamic itemsToDonate;
@dynamic donatedItems;
@dynamic requestedItems;
@dynamic email;


+ (NSString *)parseClassName{
    
    return @"User";
}

@end
