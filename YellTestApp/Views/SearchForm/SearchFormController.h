//
// Created by Vladimir Kuznetsov on 10/14/14.
// Copyright (c) 2014 Yell. All rights reserved.
//

#import <Foundation/Foundation.h>

@class UsersListController;


@interface SearchFormController : UIViewController

@property(nonatomic) NSString *searchText;
@property(nonatomic, copy) NSString *searchTextPlaceholder;
@property(nonatomic, copy) Callback onSearchButtonClicked;

- (id)initWithResultsController:(UIViewController *)resultsController;

- (void)showLoading;

- (void)setStatusText:(NSString *)text;

- (void)showResults;

@end