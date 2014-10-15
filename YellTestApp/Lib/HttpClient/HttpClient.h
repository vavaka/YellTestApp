//
// Created by Vladimir Kuznetsov on 10/14/14.
// Copyright (c) 2014 Yell. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HttpClient : NSObject<NSURLConnectionDataDelegate>

- (void)get:(NSString *)url params:(NSDictionary *)params onFinish:(ParametrizedErrorableCallback)onFinish;

- (void)post:(NSString *)url params:(NSDictionary *)params onFinish:(ParametrizedErrorableCallback)onFinish;

@end