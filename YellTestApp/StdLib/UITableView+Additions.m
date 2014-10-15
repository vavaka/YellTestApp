//
// Created by Vladimir Kuznetsov on 10/15/14.
// Copyright (c) 2014 Yell. All rights reserved.
//

#import "UITableView+Additions.h"


@implementation UITableView (Additions)

- (void)scrollToTopAnimated:(BOOL)animated {
    [self scrollRectToVisible:CGRectMake(0, 0, 1, 1) animated:animated];
}

@end