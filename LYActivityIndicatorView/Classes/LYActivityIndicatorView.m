//
//  Created by Carlos Vidal on 06/08/2015.
//  Copyright (c) 2015 Lyst Ltd. All rights reserved.
//

#import "LYActivityIndicatorView.h"
#import "LYActivityIndicatorLayer.h"

CGFloat const kAnimationDuration    = 2.f;
CGFloat const kDefaultLineWidth     = 10.f;
NSString *const kAnimationKey       = @"step";

@interface LYActivityIndicatorView ()

@property (nonatomic, strong) LYActivityIndicatorLayer *animatedLayer;
@property (nonatomic, strong) CALayer *containerLayer;

@end

@implementation LYActivityIndicatorView

- (instancetype)init {
    self = [super init];
    
    if (self != nil) {
        self.lineWidth = kDefaultLineWidth;
        self.tintColor = [UIColor blackColor];
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
    self->_lineWidth = lineWidth;
    self.animatedLayer.lineWidth = lineWidth;
}

#pragma mark - Public methods

- (void)startAnimating {
    if (self.isAnimating == YES) {
        return;
    }
    
    [CATransaction begin];
    [CATransaction setDisableActions:YES];
    
    CABasicAnimation *animation = (CABasicAnimation *)[self.animatedLayer actionForKey:kAnimationKey];
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    animation.duration      = kAnimationDuration;
    animation.fromValue     = @0.f;
    animation.toValue       = @1.f;
    animation.byValue       = @0.1f;
    animation.repeatCount   = CGFLOAT_MAX;
    
    self.animatedLayer.step = ((NSNumber*)animation.toValue).floatValue;
    [self.animatedLayer addAnimation:animation forKey:kAnimationKey];
    
    [CATransaction commit];
}

- (void)stopAnimating {
    for (CALayer *sublayer in self.containerLayer.sublayers) {
        [sublayer removeAllAnimations];
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
            self->_animatedLayer = [[LYActivityIndicatorLayer alloc] init];
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
