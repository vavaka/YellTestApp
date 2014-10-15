//
// Created by Vladimir Kuznetsov on 10/14/14.
// Copyright (c) 2014 Yell. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HttpClient.h"


@interface HttpConnectionState : NSObject

@property (nonatomic, strong) NSURLConnection *connection;
@property (nonatomic, strong) NSMutableData *receivedData;
@property (nonatomic, copy) ParametrizedErrorableCallback onFinish;

+ (HttpConnectionState *)stateWithConnection:(NSURLConnection *)connection onFinish:(ParametrizedErrorableCallback)onFinish;

@end