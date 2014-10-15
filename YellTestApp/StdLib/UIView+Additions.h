//
// Created by Vladimir Kuznetsov on 10/14/14.
// Copyright (c) 2014 Yell. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UIView (Additions)

- (CGRect)calculateCenteredRect:(CGRect)view;

- (void)removeAllSubviews;

- (void)hideKeyboard;
@end