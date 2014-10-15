//
// Created by Vladimir Kuznetsov on 10/14/14.
// Copyright (c) 2014 Yell. All rights reserved.
//

#import "UIView+Additions.h"


@implementation UIView (Additions)

- (void)fillParent:(UIView *)subview {
    [self addConstraint:[NSLayoutConstraint
            constraintWithItem:subview
                     attribute:NSLayoutAttributeLeft
                     relatedBy:NSLayoutRelationEqual
                        toItem:self
                     attribute:NSLayoutAttributeLeft
                    multiplier:1.0
                      constant:0.0]];

    [self addConstraint:[NSLayoutConstraint
            constraintWithItem:subview
                     attribute:NSLayoutAttributeRight
                     relatedBy:NSLayoutRelationEqual
                        toItem:self
                     attribute:NSLayoutAttributeRight
                    multiplier:1.0
                      constant:0.0]];

    [self addConstraint:[NSLayoutConstraint
            constraintWithItem:subview
                     attribute:NSLayoutAttributeTop
                     relatedBy:NSLayoutRelationEqual
                        toItem:self
                     attribute:NSLayoutAttributeTop
                    multiplier:1.0
                      constant:0.0]];

    [self addConstraint:[NSLayoutConstraint
            constraintWithItem:subview
                     attribute:NSLayoutAttributeBottom
                     relatedBy:NSLayoutRelationEqual
                        toItem:self
                     attribute:NSLayoutAttributeBottom
                    multiplier:1.0
                      constant:0.0]];
}

- (void)removeAllSubviews {
    for(UIView *subview in self.subviews) {
        [subview removeFromSuperview];
    }
}

- (void)hideKeyboard {
    [self endEditing:YES];
}

@end