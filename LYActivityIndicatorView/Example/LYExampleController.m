//
//  ViewController.m
//  LYActivityIndicatorView
//
//  Created by Carlos Vidal Pallin on 06/08/2015.
//  Copyright (c) 2015 Carlos Vidal Pallin. All rights reserved.
//

#import "LYExampleController.h"
#import "LYActivityIndicatorView.h"

@interface LYExampleController () <UIWebViewDelegate>

@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UIView *alertContainerView;
@property (weak, nonatomic) IBOutlet LYActivityIndicatorView *activityIndicatorView;

@end

@implementation LYExampleController

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.lyst.com"]];
    [self.webView setDelegate:self];
    [self.webView loadRequest:request];
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

#pragma mark - UIWebViewDelegate methods

- (void)webViewDidStartLoad:(UIWebView *)webView {
    [self.alertContainerView setHidden:NO];
    [self.activityIndicatorView startAnimating];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [self.alertContainerView setHidden:YES];
    [self.activityIndicatorView stopAnimating];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    [self.alertContainerView setHidden:YES];
    [self.activityIndicatorView stopAnimating];
}

@end
