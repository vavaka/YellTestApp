//
// Created by Vladimir Kuznetsov on 10/14/14.
// Copyright (c) 2014 Yell. All rights reserved.
//

#import "UsersListController.h"
#import "UserCell.h"
#import "User.h"
#import "UITableView+Additions.h"

#define CELL_IDENTIFIER @"UserCell"

@interface UsersListController ()

@property(nonatomic, strong) IBOutlet UITableView *tableView;

- (void)updateTable;

@end

@implementation UsersListController

- (id)init {
    self = [super initWithNibName:@"UsersListView" bundle:nil];
    if (self) {
        self.users = [NSArray new];
    }

    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.translatesAutoresizingMaskIntoConstraints = NO;

    UINib *nib = [UINib nibWithNibName:@"UserCellView" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:CELL_IDENTIFIER];
}


- (void)setUsers:(NSArray *)users {
    _users = users;

    [self updateTable];
}

- (void)updateTable {
    [self.tableView scrollToTopAnimated:NO];
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
    static NSString *cellIdentifier = CELL_IDENTIFIER;
    UserCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    cell.user = [self.users objectAtIndex:(NSUInteger) indexPath.row];

    return cell;
}

@end