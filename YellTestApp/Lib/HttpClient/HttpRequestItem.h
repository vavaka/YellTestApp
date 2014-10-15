//
// Created by Vladimir Kuznetsov on 10/14/14.
// Copyright (c) 2014 Yell. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface HttpRequestItem : NSObject

@property (nonatomic, strong) NSURLConnection *connection;
@property (nonatomic, strong) NSMutableData *receivedData;
@property (nonatomic, copy) ParametrizedCallback onSuccess;
@property (nonatomic, copy) ParametrizedCallback onError;

+ (HttpRequestItem *)itemWithConnection:(NSURLConnection *)connection onSuccess:(ParametrizedCallback)onSuccess onError:(ParametrizedCallback)onError;

@end