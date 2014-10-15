//
// Created by Vladimir Kuznetsov on 10/14/14.
// Copyright (c) 2014 Yell. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface VKApi : NSObject

- (void)getFriends:(NSString *)userId onSuccess:(ParametrizedCallback)onSuccess onError:(ParametrizedCallback)onError;

@end