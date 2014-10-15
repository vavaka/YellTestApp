//
// Created by Vladimir Kuznetsov on 10/14/14.
// Copyright (c) 2014 Yell. All rights reserved.
//

#import "HttpClient.h"
#import "HttpRequestItem.h"

@interface HttpClient ()

@property(nonatomic, strong) NSMutableArray *activeRequests;

- (HttpRequestItem *)itemWithConnection:(NSURLConnection *)connection;

- (NSString *)dictionaryToUrlEncodedString:(NSDictionary *)dictionary;

- (void)processRequest:(NSURLRequest *)request onFinish:(ParametrizedErrorableCallback)onFinish;

@end

static NSString *urlEncode(id obj) {
    NSString *string = [NSString stringWithFormat: @"%@", obj];
    return [string stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding];
}

@implementation HttpClient

- (id)init {
    self = [super init];
    if (self) {
        self.activeRequests = [NSMutableArray new];
    }

    return self;
}

- (HttpRequestItem *)itemWithConnection:(NSURLConnection *)connection {
    for (HttpRequestItem *activeRequestItem in self.activeRequests) {
        if (activeRequestItem.connection == connection) {
            return activeRequestItem;
        }
    }

    return nil;
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
    NSURLConnection *connection = [NSURLConnection connectionWithRequest:request delegate:self];
    if (connection) {
        HttpRequestItem *item = [HttpRequestItem itemWithConnection:connection onFinish:onFinish];
        [self.activeRequests addObject:item];
    }
}

- (void)get:(NSString *)url params:(NSDictionary *)params onFinish:(ParametrizedErrorableCallback)onFinish {
    if(params && [params count] > 0) {
        NSString *paramsQueryString = [self dictionaryToUrlEncodedString:params];
        url = [NSString stringWithFormat:@"%@?%@", url, paramsQueryString];
    }

    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]];
    [request setHTTPMethod:@"GET"];

    [self processRequest:request onFinish:onFinish];
}

- (void)post:(NSString *)url params:(NSDictionary *)params onFinish:(ParametrizedErrorableCallback)onFinish {
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]];
    [request setHTTPMethod:@"POST"];

    if(params && [params count] > 0) {
        NSString *paramsQueryString = [self dictionaryToUrlEncodedString:params];
        [request setHTTPBody:[paramsQueryString dataUsingEncoding:NSUTF8StringEncoding]];
    }

    [self processRequest:request onFinish:onFinish];
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    HttpRequestItem *item = [self itemWithConnection:connection];
    if (item) {
        item.receivedData.length = 0;
    }
}


- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    HttpRequestItem *item = [self itemWithConnection:connection];
    if (item) {
        [item.receivedData appendData:data];
    }
}


- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    HttpRequestItem *item = [self itemWithConnection:connection];
    if (item && item.onFinish) {
        [self.activeRequests removeObject:item];

        item.onFinish(nil, error);
    }
}


- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    HttpRequestItem *item = [self itemWithConnection:connection];
    if (item && item.onFinish) {
        [self.activeRequests removeObject:item];

        item.onFinish(item.receivedData, nil);
    }
}

@end