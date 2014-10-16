//
// Created by Vladimir Kuznetsov on 10/14/14.
// Copyright (c) 2014 Yell. All rights reserved.
//

#import "VKApi.h"
#import "User.h"

@interface VKApi ()

@property(nonatomic, strong) HttpClient *httpClient;
@property(nonatomic, copy) NSString *baseUrl;

- (NSString *)absoluteUrlForMethod:(NSString *)method;

- (void)parseResponse:(NSData *)data onFinish:(ParametrizedErrorableCallback)onFinish;

@end

@implementation VKApi

- (id)initWithHttpClient:(HttpClient *)httpClient {
    self = [super init];
    if (self) {
        self.httpClient = httpClient;
        self.baseUrl = @"https://api.vkontakte.ru/method";
    }

    return self;
}

- (NSString *)absoluteUrlForMethod:(NSString *)method {
    return [NSString stringWithFormat:@"%@/%@", self.baseUrl, method];
}

- (void)parseResponse:(NSData *)data onFinish:(ParametrizedErrorableCallback)onFinish {
    NSError *error;
    NSDictionary *parsedObject = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
    if (!error) {
        onFinish([parsedObject valueForKey:@"response"], nil);
    } else {
        onFinish(nil, error);
    }
}

- (void)getFriends:(NSString *)userId onFinish:(ParametrizedErrorableCallback)onFinish {
    NSDictionary *params = @{
            @"user_id" : userId,
            @"fields"  : @"uid,first_name,last_name"
    };

    [self.httpClient get:[self absoluteUrlForMethod:@"friends.get"] params:params onFinish:^(NSData *responseData, NSError *responseError) {
        [self parseResponse:responseData onFinish:^(NSArray *usersData, NSError *error) {
            if (error) {
                onFinish(nil, error);
            } else {
                NSMutableArray *users = [NSMutableArray new];
                for (NSDictionary *userData in usersData) {
                    NSString *id = [NSString stringWithFormat:@"%@", [userData valueForKey:@"uid"]];
                    NSString *fullName = [@[[userData valueForKey:@"first_name"], [userData valueForKey:@"last_name"]] componentsJoinedByString:@" "];
                    [users addObject:[User userWithId:id name:fullName]];
                }

                onFinish(users, nil);
            }

        }];
    }];
}

@end