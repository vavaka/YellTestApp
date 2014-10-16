//
// Created by Vladimir Kuznetsov on 10/14/14.
// Copyright (c) 2014 Yell. All rights reserved.
//

#import "User.h"
#import "RemoteImage.h"

@implementation User

+ (instancetype)userWithId:(NSString *)id name:(NSString *)name avatar:(RemoteImage *)avatar {
    User *user = [User new];
    user.id = id;
    user.name = name;
    user.avatar = avatar;

    return user;
}

@end