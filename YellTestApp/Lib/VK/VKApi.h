//
// Created by Vladimir Kuznetsov on 10/14/14.
// Copyright (c) 2014 Yell. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HttpClient.h"


@interface VKApi : NSObject

- (id)initWithHttpClient:(HttpClient *)httpClient;

- (void)getFriends:(NSString *)userId onFinish:(ParametrizedErrorableCallback)onFinish;

@end