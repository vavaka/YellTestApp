//
// Created by Vladimir Kuznetsov on 10/14/14.
// Copyright (c) 2014 Yell. All rights reserved.
//

#import "VKApi.h"
#import "HttpClient.h"
#import "User.h"

@interface VKApi()

@property(nonatomic, strong) HttpClient *httpClient;
@property(nonatomic, copy) NSString *baseUrl;

- (void)handleResult:(NSData *)data onSuccess:(ParametrizedCallback)onSuccess onError:(ParametrizedCallback)onError;

@end

@implementation VKApi

- (id)init {
    self = [super init];
    if (self) {
        self.httpClient = [HttpClient new];
        self.baseUrl = @"https://api.vkontakte.ru/method";
    }

    return self;
}

- (NSString *)absoluteUrlForMethod:(NSString *)method {
    return [NSString stringWithFormat:@"%@/%@", self.baseUrl, method];
}

- (void)handleResult:(NSData *)data onSuccess:(ParametrizedCallback)onSuccess onError:(ParametrizedCallback)onError {
    NSError *error;
    NSDictionary *parsedObject = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
    if(!error) {
        if(parsedObject && onSuccess) {
            onSuccess([parsedObject valueForKey:@"response"]);
        }
    } else {
        if(onError) {
            onError(error);
        }
    }
}

- (void)getFriends:(NSString *)userId onSuccess:(ParametrizedCallback)onSuccess onError:(ParametrizedCallback)onError {
    NSDictionary *params = @{
            @"user_id" : userId,
            @"fields" : @"uid,first_name,last_name"
    };

    [self.httpClient get:[self absoluteUrlForMethod:@"friends.get"] params:params onSuccess:^(NSData *data) {
        [self handleResult:data onSuccess:^(NSArray *usersData) {
            NSMutableArray *users = [NSMutableArray new];
            for(NSDictionary *userData in usersData) {
                NSString *id = [NSString stringWithFormat: @"%@", [userData valueForKey:@"uid"]];
                NSString *fullName = [@[[userData valueForKey:@"first_name"], [userData valueForKey:@"last_name"]] componentsJoinedByString:@" "];
                [users addObject:[User userWithId:id name:fullName]];
            }

            if(onSuccess) {
                onSuccess(users);
            }
        } onError:onError];
    } onError:onError];
}

@end