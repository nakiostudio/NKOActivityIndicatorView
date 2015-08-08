//
//  ViewController.m
//  LYActivityIndicatorView
//
//  Created by Carlos Vidal Pallin on 06/08/2015.
//  Copyright (c) 2015 Carlos Vidal Pallin. All rights reserved.
//

#import "ViewController.h"
#import "LYActivityIndicatorView.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet LYActivityIndicatorView *activityIndicatorView;

@end

@implementation ViewController

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [self.activityIndicatorView startAnimating];
}

- (IBAction)_action:(UIButton*)sender {
    if (self.activityIndicatorView.isAnimating) {
        [self.activityIndicatorView stopAnimating];
        [sender setTitle:@"Animate" forState:UIControlStateNormal];
    }
    else {
        [self.activityIndicatorView startAnimating];
        [sender setTitle:@"Stop" forState:UIControlStateNormal];
    }
}

@end
