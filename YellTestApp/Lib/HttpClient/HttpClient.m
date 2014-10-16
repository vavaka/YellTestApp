//
// Created by Vladimir Kuznetsov on 10/14/14.
// Copyright (c) 2014 Yell. All rights reserved.
//

#import "HttpClient.h"

@interface HttpClient ()

@property(nonatomic, strong) NSOperationQueue *connectionQueue;

- (NSString *)dictionaryToUrlEncodedString:(NSDictionary *)dictionary;

- (void)processRequest:(NSURLRequest *)request onFinish:(ParametrizedErrorableCallback)onFinish;
@end

static NSString *urlEncode(id obj) {
    NSString *string = [NSString stringWithFormat:@"%@", obj];
    return [string stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
}

@implementation HttpClient

- (id)initWithQueueCapacity:(NSInteger)queueCapacity {
    self = [super init];
    if (self) {
        self.connectionQueue = [[NSOperationQueue alloc] init];
        [self.connectionQueue setMaxConcurrentOperationCount:queueCapacity];
    }

    return self;
}

- (NSString *)dictionaryToUrlEncodedString:(NSDictionary *)dictionary {
    NSMutableArray *parts = [NSMutableArray array];
    for (id key in dictionary) {
        id value = [dictionary objectForKey:key];
        NSString *part = [NSString stringWithFormat:@"%@=%@", urlEncode(key), urlEncode(value)];
        [parts addObject:part];
    }
    return [parts componentsJoinedByString:@"&"];
}

- (void)processRequest:(NSURLRequest *)request onFinish:(ParametrizedErrorableCallback)onFinish {
    [NSURLConnection sendAsynchronousRequest:request queue:self.connectionQueue completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
        onFinish(data, error);
    }];
}

- (NSMutableURLRequest *)requestWithMethod:(NSString *)method to:(NSString *)to {
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:to]];
    [request setHTTPMethod:method];

    return request;
}

- (void)get:(NSString *)url params:(NSDictionary *)params onFinish:(ParametrizedErrorableCallback)onFinish {
    if (params && [params count] > 0) {
        NSString *paramsQueryString = [self dictionaryToUrlEncodedString:params];
        url = [NSString stringWithFormat:@"%@?%@", url, paramsQueryString];
    }

    NSURLRequest *request = [self requestWithMethod:@"GET" to:url];
    [self processRequest:request onFinish:onFinish];
}

- (void)post:(NSString *)url params:(NSDictionary *)params onFinish:(ParametrizedErrorableCallback)onFinish {
    NSMutableURLRequest *request = [self requestWithMethod:@"POST" to:url];

    if (params && [params count] > 0) {
        NSString *paramsQueryString = [self dictionaryToUrlEncodedString:params];
        [request setHTTPBody:[paramsQueryString dataUsingEncoding:NSUTF8StringEncoding]];
    }

    [self processRequest:request onFinish:onFinish];
}

@end