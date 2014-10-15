//
// Created by Vladimir Kuznetsov on 10/14/14.
// Copyright (c) 2014 Yell. All rights reserved.
//

#import "UserCell.h"
#import "User.h"

@interface UserCell ()

@property(nonatomic, strong) UILabel *labelName;
@property(nonatomic, strong) UILabel *labelId;

@end

@implementation UserCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];

    if (self) {
        self.labelName = [[UILabel alloc] initWithFrame:CGRectMake(10, 8, 310, 15)];
        self.labelName.numberOfLines = 1;
        self.labelName.font = [UIFont systemFontOfSize:14];
        self.labelName.textColor = [UIColor blackColor];
        self.labelName.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:self.labelName];

        self.labelId = [[UILabel alloc] initWithFrame:CGRectMake(10, 25, 310, 15)];
        self.labelId.numberOfLines = 1;
        self.labelId.font = [UIFont systemFontOfSize:12];
        self.labelId.textColor = [UIColor grayColor];
        self.labelId.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:self.labelId];

        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    return self;
}

- (void)setUser:(User *)user {
    _user = user;

    [self updateUI];
}

- (void)updateUI {
    self.labelName.text = self.user.name;
    self.labelId.text = [NSString stringWithFormat:@"#%@", self.user.id];
}

@end