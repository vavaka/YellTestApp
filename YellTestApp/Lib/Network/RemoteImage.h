//
// Created by Vladimir Kuznetsov on 10/16/14.
// Copyright (c) 2014 Yell. All rights reserved.
//

#import <Foundation/Foundation.h>

@class HttpClient;


@interface RemoteImage : NSObject

@property(nonatomic, copy) NSString *url;

- (instancetype)initWithHttpClient:(HttpClient *)httpClient url:(NSString *)url;

- (instancetype)initWithUrl:(NSString *)url;

+ (void)setDefaultHttpClient:(HttpClient *)httpClient;

- (void)load:(ParametrizedErrorableCallback)onFinish;

@end