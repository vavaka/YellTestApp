//
// Created by Vladimir Kuznetsov on 10/14/14.
// Copyright (c) 2014 Yell. All rights reserved.
//

#import "SearchFormController.h"
#import "UIView+Additions.h"

@interface SearchFormController ()

@property(nonatomic, strong) IBOutlet UITextField *textSubject;
@property(nonatomic, strong) IBOutlet UIButton *buttonSearch;
@property(nonatomic, strong) IBOutlet UILabel *labelStatus;
@property(nonatomic, strong) IBOutlet UIView *viewResults;

@property(nonatomic, strong) UIViewController *resultController;
@property(nonatomic, strong) UIActivityIndicatorView *activityIndicator;

- (void)hideAll;

- (void)buttonSearchClicked;

@end

@implementation SearchFormController

- (id)initWithResultsController:(UIViewController *)resultsController {
    self = [super initWithNibName:@"SearchFormView" bundle:nil];
    if (self) {
        self.resultController = resultsController;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    self.activityIndicator.frame = [self.viewResults calculateCenteredRect:self.activityIndicator.bounds];
    self.activityIndicator.hidden = YES;
    [self.view addSubview:self.activityIndicator];

    self.labelStatus.font = [UIFont systemFontOfSize:12];
    self.labelStatus.textColor = [UIColor grayColor];

    self.textSubject.placeholder = self.searchTextPlaceholder;

    self.buttonSearch.titleLabel.text = NSLocalizedString(@"Search", nil);
    [self.buttonSearch addTarget:self action:@selector(buttonSearchClicked) forControlEvents:UIControlEventTouchUpInside];

    self.resultController.view.frame = self.viewResults.bounds;
    [self.viewResults addSubview:self.resultController.view];
}

- (void)hideAll {
    self.labelStatus.hidden = YES;
    self.viewResults.hidden = YES;
    [self.activityIndicator stopAnimating];
    self.activityIndicator.hidden = YES;
}

- (void)showLoading {
    [self hideAll];

    [self.activityIndicator startAnimating];
    self.activityIndicator.hidden = NO;
}

- (void)showResults {
    [self hideAll];

    self.labelStatus.hidden = NO;
    self.viewResults.hidden = NO;
}

- (void)setStatusText:(NSString *)text {
    self.labelStatus.text = text;
}

- (void)buttonSearchClicked {
    [self.view hideKeyboard];

    if(self.onSearchButtonClicked) {
        self.onSearchButtonClicked();
    }
}

- (NSString *)searchText {
    return self.textSubject.text;
}

- (void)setSearchText:(NSString *)value {
    self.textSubject.text = value;
}

@end