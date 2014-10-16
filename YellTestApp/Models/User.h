//
// Created by Vladimir Kuznetsov on 10/14/14.
// Copyright (c) 2014 Yell. All rights reserved.
//

#import <Foundation/Foundation.h>

@class RemoteImage;


@interface User : NSObject

@property(nonatomic, copy) NSString *id;
@property(nonatomic, copy) NSString *name;
@property(nonatomic, strong) RemoteImage *avatar;

+ (instancetype)userWithId:(NSString *)id name:(NSString *)name avatar:(RemoteImage *)avatar;

@end