//
// Created by Vladimir Kuznetsov on 10/16/14.
// Copyright (c) 2014 Yell. All rights reserved.
//

#import "RemoteImage.h"
#import "HttpClient.h"

#define DEFAULT_HTTP_CLIENT_QUEUE_CAPACITY  5

@interface RemoteImage()

@property(nonatomic, strong) HttpClient *httpClient;
@property(nonatomic, strong) NSData *data;

+ (HttpClient *)defaultHttpClient;
@end

static HttpClient *_remoteImageHttpClient;

@implementation RemoteImage

- (instancetype)initWithHttpClient:(HttpClient *)httpClient url:(NSString *)url {
    self = [super init];
    if (self) {
        self.httpClient = httpClient;
        self.url = url;
    }

    return self;
}

- (instancetype)initWithUrl:(NSString *)url {
    return [self initWithHttpClient:[RemoteImage defaultHttpClient] url:url];
}

+ (HttpClient *)defaultHttpClient {
    if(!_remoteImageHttpClient) {
        [RemoteImage setDefaultHttpClient:[[HttpClient alloc] initWithQueueCapacity:DEFAULT_HTTP_CLIENT_QUEUE_CAPACITY]];
    }

    return _remoteImageHttpClient;
}

+ (void)setDefaultHttpClient:(HttpClient *)httpClient {
    _remoteImageHttpClient = httpClient;
}

- (void)load:(ParametrizedErrorableCallback)onFinish {
    if(self.data) {
        onFinish(self.data, nil);
    } else {
        [self.httpClient get:self.url params:nil onFinish:^(NSData *data, NSError *error) {
            self.data = data;
            onFinish(data, error);
        }];
    }
}


@end