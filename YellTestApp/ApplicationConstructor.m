//
// Created by Vladimir Kuznetsov on 10/15/14.
// Copyright (c) 2014 Yell. All rights reserved.
//

#import "ApplicationConstructor.h"
#import "VKApi.h"
#import "User.h"
#import "SearchFormController.h"
#import "UsersListController.h"

@implementation ApplicationConstructor

- (UIViewController *)createSearchFriendsController {
    __block ApplicationConstructor *__self = self;
    __block UsersListController *usersListController = [UsersListController new];
    __block SearchFormController *searchFormController = [[SearchFormController alloc] initWithResultsController:usersListController];

    searchFormController.searchTextPlaceholder = NSLocalizedString(@"User ID", nil);
    searchFormController.searchTextKeyboardType = UIKeyboardTypeNumberPad;

    ParametrizedCallback searchFriends = ^(NSString *userId) {
        [searchFormController showLoading];

        [__self.api getFriends:userId onFinish:^(NSArray *users, NSError *error) {
            [searchFormController showResults];

            if(error) {
                [searchFormController setStatusText:NSLocalizedString(@"Error", nil)];
                NSLog(@"Error:\n%@", error.description);
            } else {
                usersListController.users = users;
                [searchFormController setStatusText:NSLocalizedFormatString(@"Found %d friend(s) for user #%@", users.count, userId)];
            }
        }];
    };

    usersListController.onItemSelected = ^(User *user) {
        searchFriends(user.id);
    };

    searchFormController.onSearchButtonClicked = ^() {
        searchFriends(searchFormController.searchText);
    };

    return searchFormController;
}

@end