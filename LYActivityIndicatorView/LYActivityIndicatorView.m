//
//  Created by Carlos Vidal on 06/08/2015.
//  Copyright (c) 2015 Lyst Ltd. All rights reserved.
//

#import "LYActivityIndicatorView.h"
#import "LYActivityIndicatorLayer.h"

CGFloat const kDefaultLineWidth = 10.f;

@interface LYActivityIndicatorView ()

@property (nonatomic, strong) LYActivityIndicatorLayer *animatedLayer;
@property (nonatomic, strong) CALayer *containerLayer;

@end

@implementation LYActivityIndicatorView

- (instancetype)init {
    self = [super init];
    
    if (self != nil) {
        self.lineWidth = kDefaultLineWidth;
        self.color = [UIColor blackColor];
    }
    
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.lineWidth = kDefaultLineWidth;
    self.color = [UIColor blackColor];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.containerLayer.frame = self.bounds;
    self.animatedLayer.frame = self.bounds;
}

- (void)setFrame:(CGRect)frame {
    [super setFrame:frame];
    
    self.animatedLayer.frame = CGRectMake(0.f, 0.f, CGRectGetWidth(frame), CGRectGetHeight(frame));
}

#pragma mark - Public methods

- (void)startAnimating {
    [self stopAnimating];
    
    [CATransaction begin];
    [CATransaction setDisableActions:YES];
    
    CABasicAnimation *animation = (CABasicAnimation *)[self.animatedLayer actionForKey:@"step"];
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    animation.duration      = 3.f;
    animation.fromValue     = @0.f;
    animation.toValue       = @1.f;
    animation.byValue       = @0.1f;
    animation.repeatCount   = CGFLOAT_MAX;
    
    self.animatedLayer.step = ((NSNumber*)animation.toValue).floatValue;
    [self.animatedLayer addAnimation:animation forKey:@"step"];
    
    [CATransaction commit];
}

- (void)stopAnimating {
    for (CALayer *sublayer in self.containerLayer.sublayers) {
        [sublayer removeAllAnimations];
    }
}

#pragma mark - Lazy loading

- (CALayer *)containerLayer {
    if (self->_containerLayer == nil) {
        self->_containerLayer = [[CALayer alloc] init];
        self->_containerLayer.frame = self.bounds;
        self->_containerLayer.backgroundColor = [UIColor clearColor].CGColor;
        
        if (self->_animatedLayer == nil) {
            self->_animatedLayer = [[LYActivityIndicatorLayer alloc] init];
            self->_animatedLayer.color = self.color.CGColor;
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
