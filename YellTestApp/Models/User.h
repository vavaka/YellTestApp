//
// Created by Vladimir Kuznetsov on 10/14/14.
// Copyright (c) 2014 Yell. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface User : NSObject

@property(nonatomic, copy) NSString *id;
@property(nonatomic, copy) NSString *name;

+ (instancetype)userWithId:(NSString *)id1 name:(NSString *)name;

@end