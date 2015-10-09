//
//  NKOActivityIndicatorLayer.m
//  NKOActivityIndicatorView
//
//  Created by Carlos Vidal Pallin on 07/08/2015.
//  Copyright (c) 2015 Carlos Vidal Pallin. All rights reserved.
//

#import <UIKit/UIKit.h>

IB_DESIGNABLE
@interface NKOActivityIndicatorView : UIView

@property (nonatomic, strong) IBInspectable UIColor *color;
@property (nonatomic, assign) IBInspectable CGFloat lineWidth;
@property (nonatomic, assign) IBInspectable BOOL hidesWhenStopped;

- (instancetype)initWithFrame:(CGRect)frame;
- (instancetype)initWithCoder:(NSCoder *)coder;

- (void)startAnimating;
- (void)stopAnimating;
- (BOOL)isAnimating;

@end
