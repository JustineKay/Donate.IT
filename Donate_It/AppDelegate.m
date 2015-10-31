//
//  AppDelegate.m
//  Donate_It
//
//  Created by Justine Kay on 10/31/15.
//  Copyright © 2015 Justine Kay. All rights reserved.
//

#import "AppDelegate.h"
#import <Parse/Parse.h>
#import "User.h"
#import "Listing.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [Parse setApplicationId:@"6IUt3gHphBOmADc1mk7qLYXLQFjyEnO1JivE1ODP"
                  clientKey:@"uvokIqZXW8zAQkIG5Vv4meKa7jU7WWhWRlfOj5Mo"];
    
    [User registerSubclass];
    [Listing registerSubclass];
    
//    Listing *parseTestListing = [[Listing alloc] init];
//    parseTestListing.title = @"This is a test title";
//    parseTestListing.deviceType = @"test laptop";
//    
//    [parseTestListing saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
//        if (succeeded) {
//            NSLog(@"Object Uploaded!");
//        }else{
//            NSLog(@"Error: %@", [error localizedDescription]);
//        }
//    }];
    
    User *parseTestUser = [[User alloc] init];
    parseTestUser.email = @"testEmail@email.com";
    
    [parseTestUser saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
        if (succeeded) {
            NSLog(@"Object uploaded!");
        }else{
            NSLog(@"Error: %@", [error localizedDescription]);
        }
    }];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
