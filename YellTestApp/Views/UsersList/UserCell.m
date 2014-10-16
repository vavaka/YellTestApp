//
// Created by Vladimir Kuznetsov on 10/14/14.
// Copyright (c) 2014 Yell. All rights reserved.
//

#import "UserCell.h"
#import "User.h"
#import "RemoteImage.h"

@interface UserCell ()

@property(nonatomic, strong) IBOutlet UILabel *labelName;
@property(nonatomic, strong) IBOutlet UILabel *labelId;
@property(nonatomic, strong) IBOutlet UIImageView *imageAvatar;

@end

@implementation UserCell

- (void)layoutSubviews {
    [super layoutSubviews];

    self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

    self.labelName.numberOfLines = 1;
    self.labelName.font = [UIFont systemFontOfSize:14];
    self.labelName.textColor = [UIColor blackColor];

    self.labelId.numberOfLines = 1;
    self.labelId.font = [UIFont systemFontOfSize:12];
    self.labelId.textColor = [UIColor grayColor];
}

- (void)setUser:(User *)user {
    _user = user;

    [self updateUI];
}

- (void)updateUI {
    self.labelName.text = self.user.name;
    self.labelId.text = [NSString stringWithFormat:@"#%@", self.user.id];

    self.imageAvatar.image = nil;
    if (self.user.avatar) {
        [self.user.avatar load:^(NSData *data, NSError *error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                if(error) {
                    NSLog(@"Error loading remote image '%@':\n%@", self.user.avatar.url, error);
                } else {
                    self.imageAvatar.image = [UIImage imageWithData:data];
                }
            });
        }];
    }

}

@end