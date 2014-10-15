//
// Created by Vladimir Kuznetsov on 10/14/14.
// Copyright (c) 2014 Yell. All rights reserved.
//

#import "UsersListController.h"
#import "UserCell.h"
#import "User.h"

@interface UsersListController ()

@property(nonatomic, strong) IBOutlet UITableView *tableView;

@end

@implementation UsersListController

- (id)init {
    self = [super initWithNibName:@"UsersListView" bundle:nil];
    if (self) {
        self.users = [NSArray new];
    }

    return self;
}

- (void)setUsers:(NSArray *)users {
    _users = users;

    [self.tableView reloadData];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.users.count;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 1)];
    view.backgroundColor = [UIColor clearColor];
    return view;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if(self.onItemSelected) {
        User *user = [self.users objectAtIndex:(NSUInteger) indexPath.row];
        self.onItemSelected(user);
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"UserCell";
    UserCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];

    if (cell == nil) {
        cell = [[UserCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }

    cell.user = [self.users objectAtIndex:(NSUInteger) indexPath.row];

    return cell;
}

@end