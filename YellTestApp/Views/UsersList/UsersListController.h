//
// Created by Vladimir Kuznetsov on 10/14/14.
// Copyright (c) 2014 Yell. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface UsersListController : UIViewController<UITableViewDataSource, UITableViewDelegate>

@property(nonatomic, copy) ParametrizedCallback onItemSelected;
@property(nonatomic, strong) NSArray *users;

@end