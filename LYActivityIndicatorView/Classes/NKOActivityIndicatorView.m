//
//  NKOActivityIndicatorLayer.m
//  NKOActivityIndicatorView
//
//  Created by Carlos Vidal Pallin on 07/08/2015.
//  Copyright (c) 2015 Carlos Vidal Pallin. All rights reserved.
//

#import "NKOActivityIndicatorView.h"
#import "NKOActivityIndicatorLayer.h"

CGFloat const kAnimationDuration    = 2.f;
CGFloat const kDefaultLineWidth     = 10.f;
NSString *const kAnimationKey       = @"step";

@interface NKOActivityIndicatorView ()

@property (nonatomic, strong) NKOActivityIndicatorLayer *animatedLayer;
@property (nonatomic, strong) CALayer *containerLayer;

@end

@implementation NKOActivityIndicatorView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    if (self != nil) {
        self.tintColor = [UIColor blackColor];
        self->_lineWidth = kDefaultLineWidth;
        self->_hidesWhenStopped = YES;
    }
    
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    
    if (self != nil) {
        self.tintColor = [UIColor blackColor];
        self->_lineWidth = kDefaultLineWidth;
        self->_hidesWhenStopped = YES;
    }
    
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.containerLayer.frame = self.bounds;
    self.animatedLayer.frame = self.bounds;
}

- (void)prepareForInterfaceBuilder {
    self.containerLayer.frame = self.bounds;
    self.animatedLayer.step = 0.625f;
}

#pragma mark - Accessors

- (void)setFrame:(CGRect)frame {
    [super setFrame:frame];
    
    self.animatedLayer.frame = CGRectMake(0.f, 0.f, CGRectGetWidth(frame), CGRectGetHeight(frame));
}

- (void)setTintColor:(UIColor *)tintColor
{
    [super setTintColor:tintColor];
    self.animatedLayer.color = tintColor.CGColor;
}

- (void)setLineWidth:(CGFloat)lineWidth {
    CGFloat adjustedLineWidth = fmax(1.f, fmod(lineWidth, 2.f) != 0 ? lineWidth - 1.f : lineWidth);
    self->_lineWidth = adjustedLineWidth;
    self.animatedLayer.lineWidth = adjustedLineWidth;
}

- (void)setColor:(UIColor *)color {
    self.tintColor = color;
}

- (UIColor *)color {
    return self.tintColor;
}

#pragma mark - Public methods

- (void)startAnimating {
    if (self.isAnimating) {
        return;
    }
    
    self.hidden = NO;
    
    [CATransaction begin];
    [CATransaction setDisableActions:YES];
    
    CABasicAnimation *animation = (CABasicAnimation *)[self.animatedLayer actionForKey:kAnimationKey];
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    animation.repeatCount   = CGFLOAT_MAX;
    animation.duration      = kAnimationDuration;
    animation.fromValue     = @0.f;
    animation.toValue       = @1.f;
    animation.byValue       = @0.1f;
    
    self.animatedLayer.step = ((NSNumber*)animation.toValue).floatValue;
    [self.animatedLayer addAnimation:animation forKey:kAnimationKey];
    
    [CATransaction commit];
}

- (void)stopAnimating {
    for (CALayer *sublayer in self.containerLayer.sublayers) {
        [sublayer removeAllAnimations];
    }
    
    if (self.hidesWhenStopped) {
        self.hidden = YES;
    }
}

- (BOOL)isAnimating {
    for (CALayer *layer in self.containerLayer.sublayers) {
        if ([layer animationForKey:kAnimationKey] != nil)
            return YES;
    }
    
    return NO;
}

#pragma mark - Lazy loading

- (CALayer *)containerLayer {
    if (self->_containerLayer == nil) {
        self->_containerLayer = [[CALayer alloc] init];
        self->_containerLayer.frame = self.bounds;
        self->_containerLayer.backgroundColor = [UIColor clearColor].CGColor;
        
        if (self->_animatedLayer == nil) {
            self->_animatedLayer = [[NKOActivityIndicatorLayer alloc] init];
            self->_animatedLayer.color = self.tintColor.CGColor;
            self->_animatedLayer.lineWidth = self.lineWidth;
            self->_animatedLayer.backgroundColor = [UIColor clearColor].CGColor;
        }
        
        if (self->_animatedLayer.superlayer == nil) {
            [self->_containerLayer addSublayer:self->_animatedLayer];
        }
    }
    
    if (self->_containerLayer.superlayer == nil) {
        [self.layer addSublayer:self->_containerLayer];
    }
    
    return self->_containerLayer;
}

@end
