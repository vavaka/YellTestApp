//
// Created by Vladimir Kuznetsov on 10/14/14.
// Copyright (c) 2014 Yell. All rights reserved.
//

#import "HttpConnectionState.h"


@implementation HttpConnectionState

+ (HttpConnectionState *)stateWithConnection:(NSURLConnection *)connection onFinish:(ParametrizedErrorableCallback)onFinish {
    HttpConnectionState *response = [HttpConnectionState new];
    response.connection = connection;
    response.receivedData = [NSMutableData new];
    response.onFinish = onFinish;

    return response;
}

@end