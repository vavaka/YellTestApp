//
// Created by Vladimir Kuznetsov on 10/14/14.
// Copyright (c) 2014 Yell. All rights reserved.
//

#import "HttpRequestItem.h"


@implementation HttpRequestItem

+ (HttpRequestItem *)itemWithConnection:(NSURLConnection *)connection onFinish:(ParametrizedErrorableCallback)onFinish {
    HttpRequestItem *item = [HttpRequestItem new];
    item.connection = connection;
    item.receivedData = [NSMutableData new];
    item.onFinish = onFinish;

    return item;
}

@end