//
//  AppDelegate.m
//  YellTestApp
//
//  Created by Vladimir Kuznetsov on 10/14/14.
//  Copyright (c) 2014 Yell. All rights reserved.
//

#import "AppDelegate.h"
#import "SearchFormController.h"
#import "UsersListController.h"
#import "VKApi.h"
#import "User.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    __block VKApi *api = [VKApi new];

    __block UsersListController *usersListController = [UsersListController new];
    __block SearchFormController *searchFriendsController = [[SearchFormController alloc] initWithResultsController:usersListController];
    searchFriendsController.searchTextPlaceholder = NSLocalizedString(@"User ID", nil);

    ParametrizedCallback searchFriends = ^(NSString *id) {
        [searchFriendsController showLoading];

        [api getFriends:id onFinish:^(NSArray *users, NSError *error) {
            [searchFriendsController showResults];

            if(error) {
                [searchFriendsController setStatusText:NSLocalizedString(@"Error", nil)];
                NSLog(@"Error:\n%@", error.description);
            } else {
                usersListController.users = users;
                [searchFriendsController setStatusText:NSLocalizedFormatString(@"Found %d friend(s) for user #%@", users.count, id)];
            }
        }];
    };

    usersListController.onItemSelected = ^(User *user) {
        searchFriends(user.id);
    };

    searchFriendsController.onSearchButtonClicked = ^() {
        searchFriends(searchFriendsController.searchText);
    };

    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    self.window.rootViewController = searchFriendsController;
    [self.window makeKeyAndVisible];
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
