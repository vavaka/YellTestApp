//
// Created by Vladimir Kuznetsov on 10/14/14.
// Copyright (c) 2014 Yell. All rights reserved.
//

#import "VKApi.h"
#import "User.h"
#import "RemoteImage.h"

@interface VKApi ()

@property(nonatomic, strong) HttpClient *httpClient;
@property(nonatomic, copy) NSString *baseUrl;

- (NSString *)absoluteUrlForMethod:(NSString *)method;

- (void)parseResponse:(NSData *)data onFinish:(ParametrizedErrorableCallback)onFinish;

- (User *)userFromDictionary:(NSDictionary *)data;

- (NSArray *)usersFromArrayData:(NSArray *)array;

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

- (User *)userFromDictionary:(NSDictionary *)data {
    NSString *id = [NSString stringWithFormat:@"%@", [data valueForKey:@"uid"]];
    NSString *fullName = [@[[data valueForKey:@"first_name"], [data valueForKey:@"last_name"]] componentsJoinedByString:@" "];
    RemoteImage *avatar = [[RemoteImage alloc] initWithUrl:[data valueForKey:@"photo"]];
    return [User userWithId:id name:fullName avatar:avatar];
}

- (NSArray *)usersFromArrayData:(NSArray *)array {
    NSMutableArray *result = [NSMutableArray new];
    for (NSDictionary *entry in array) {
        [result addObject:[self userFromDictionary:entry]];
    }

    return result;
}

- (void)getFriends:(NSString *)userId onFinish:(ParametrizedErrorableCallback)onFinish {
    NSDictionary *params = @{
            @"user_id" : userId,
            @"fields"  : @"uid,first_name,last_name,photo"
    };

    [self.httpClient get:[self absoluteUrlForMethod:@"friends.get"] params:params onFinish:^(NSData *responseData, NSError *responseError) {
        [self parseResponse:responseData onFinish:^(NSArray *parsedResult, NSError *error) {
            if (error) {
                onFinish(nil, error);
            } else {
                NSArray *users = [self usersFromArrayData:parsedResult];
                onFinish(users, nil);
            }

        }];
    }];
}

@end