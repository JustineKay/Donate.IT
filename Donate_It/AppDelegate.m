//
//  AppDelegate.m
//  Donate_It
//
//  Created by Justine Kay on 10/31/15.
//  Copyright © 2015 Justine Kay. All rights reserved.
//

//Emerald Green Color: R: 113 G: 211 B: 152 , Hex code: #71D398

#import "AppDelegate.h"
#import <Parse/Parse.h>
#import "User.h"
#import "Listing.h"
#import "LogInViewController.h"
#import "ListingsViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    //Set up Parse
    
    [Parse setApplicationId:@"6IUt3gHphBOmADc1mk7qLYXLQFjyEnO1JivE1ODP"
                  clientKey:@"uvokIqZXW8zAQkIG5Vv4meKa7jU7WWhWRlfOj5Mo"];
    
    [User registerSubclass];
    [Listing registerSubclass];
    
    
    NSLog(@"Username: %@", [[NSUserDefaults standardUserDefaults] objectForKey:UsernameKey]);
    
    //Check if there is a username saved in NSUserDefaults
    
    //if not, RootViewController of the Storyboard is the LogInViewController
    
    //otherwise make the ListingsViewController the RootViewController of the storyboard
    
    if (![[NSUserDefaults standardUserDefaults] objectForKey:UsernameKey]) {
        
        UIStoryboard *storyboard = self.window.rootViewController.storyboard;
        
        UIViewController *logInViewController = [storyboard instantiateViewControllerWithIdentifier:@"LogInViewController"];
        
        self.window.rootViewController = logInViewController;
        
        [self.window makeKeyAndVisible];
        
    }else {
        
        
        UIStoryboard *storyboard = self.window.rootViewController.storyboard;
        
        ListingsViewController *listingsVC = [storyboard instantiateViewControllerWithIdentifier:@"ListingsViewController"];
    
        self.window.rootViewController = listingsVC;
        
        [self.window makeKeyAndVisible];
        
    }

    
    //Testing Parse Here
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
    
//    User *parseTestUser = [[User alloc] init];
//    parseTestUser.username = @"testUser";
//    parseTestUser.password = @"testPassword1234";
//    parseTestUser.email = @"testEmail@email.com";
//    
//    [parseTestUser signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
//        if (!error) {
//            // Hooray! Let them use the app now.
//        } else {
//            
//            NSLog(@"Error: %@",[error userInfo][@"error"]);
//        }
//    }];
    
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
