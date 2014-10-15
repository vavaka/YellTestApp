//
// Created by Vladimir Kuznetsov on 10/15/14.
// Copyright (c) 2014 Yell. All rights reserved.
//

#import <Foundation/Foundation.h>

@class VKApi;


@interface ApplicationConstructor : NSObject

@property(nonatomic, strong) VKApi *api;

- (UIViewController *)createSearchFriendsController;

@end