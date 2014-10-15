//
// Created by Vladimir Kuznetsov on 10/14/14.
// Copyright (c) 2014 Yell. All rights reserved.
//

#import "User.h"


@implementation User

+ (instancetype)userWithId:(NSString *)id name:(NSString *)name {
    User *user = [User new];
    user.id = id;
    user.name = name;

    return user;
}

@end