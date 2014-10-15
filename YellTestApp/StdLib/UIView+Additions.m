//
// Created by Vladimir Kuznetsov on 10/14/14.
// Copyright (c) 2014 Yell. All rights reserved.
//

#import "UIView+Additions.h"


@implementation UIView (Additions)

- (CGRect)calculateCenteredRect:(CGRect)rect {
    return CGRectMake(
            (self.bounds.size.width - rect.size.width) / 2,
            (self.bounds.size.height - rect.size.height) / 2,
            rect.size.width,
            rect.size.height
    );
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