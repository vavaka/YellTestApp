//
// Created by Vladimir Kuznetsov on 10/14/14.
// Copyright (c) 2014 Yell. All rights reserved.
//

#import "HttpRequestItem.h"


@implementation HttpRequestItem

+ (HttpRequestItem *)itemWithConnection:(NSURLConnection *)connection onSuccess:(ParametrizedCallback)onSuccess onError:(ParametrizedCallback)onError {
    HttpRequestItem *item = [HttpRequestItem new];
    item.connection = connection;
    item.receivedData = [NSMutableData new];
    item.onSuccess = onSuccess;
    item.onError = onSuccess;

    return item;
}

@end