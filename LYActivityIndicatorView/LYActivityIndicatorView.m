//
//  Created by Carlos Vidal on 06/08/2015.
//  Copyright (c) 2015 Lyst Ltd. All rights reserved.
//

#import "LYActivityIndicatorView.h"

CGFloat const kSegmentLapse     = 0.125f;
CGFloat const kDefaultLineWidth = 10.f;

@interface LYActivityIndicatorLayer : CALayer

@property (nonatomic, assign) CGFloat step;

@property (nonatomic, strong) UIColor *color;
@property (nonatomic, assign) CGFloat lineWidth;

@end

@implementation LYActivityIndicatorLayer

- (instancetype)init {
    self = [super init];
    
    if (self != nil) {
        self->_color = [UIColor blackColor];
        self->_lineWidth = kDefaultLineWidth;
        self.needsDisplayOnBoundsChange = YES;
    }
    
    return self;
}

- (instancetype)initWithLayer:(id)layer {
    self = [super initWithLayer:layer];
    
    if (self != nil) {
        LYActivityIndicatorLayer *sourceLayer = layer;
        self->_color = sourceLayer.color;
        self->_lineWidth = sourceLayer.lineWidth;
        self.backgroundColor = sourceLayer.backgroundColor;
        self.needsDisplayOnBoundsChange = YES;
    }
    
    return self;
}

- (void)drawInContext:(CGContextRef)ctx {
    [super drawInContext:ctx];
    
    [self _drawSpinInContext:ctx withStep:self.step];
}

- (void)_drawSpinInContext:(CGContextRef)ctx withStep:(CGFloat)step {
    static NSUInteger segments = 8;
    
    for (int segment = 0; segment <= segments; segment++) {
        if (step >= kSegmentLapse*segment) {
            CGPoint pointA = [self _pointAforSegment:segment step:step];
            CGPoint pointB = [self _pointBforSegment:segment step:step];
            [self _drawLineInContext:ctx from:pointA to:pointB];
        }
    }
    
}

- (CGPoint)_pointAforSegment:(NSUInteger)segment step:(CGFloat)step {
    switch (segment) {
        case 0:
            return CGPointMake(0.f, 0.f);
        case 1:
            return CGPointMake(CGRectGetWidth(self.bounds), 0.f);
        case 2:
            return CGPointMake(CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds));
        case 3:
            return CGPointMake(0.f, CGRectGetHeight(self.bounds));
        case 4:
            return CGPointZero;
        case 5:
            return CGPointZero;
        case 6:
            return CGPointZero;
        case 7:
            return CGPointZero;
        default:
            return CGPointZero;
    }
}

- (CGPoint)_pointBforSegment:(NSUInteger)segment step:(CGFloat)step {
    CGFloat pos = step < (kSegmentLapse*(segment+1)) ? (step - kSegmentLapse*(segment))/kSegmentLapse : 1.f;
    CGFloat width = CGRectGetWidth(self.bounds);
    CGFloat height = CGRectGetWidth(self.bounds);
    
    switch (segment) {
        case 0:
            return CGPointMake(width*pos, 0.f);
        case 1:
            return CGPointMake(width, height*pos);
        case 2:
            return CGPointMake(width-(width*pos), height);
        case 3:
            return CGPointMake(0.f, height-(height*pos));
        case 4:
            return CGPointZero;
        case 5:
            return CGPointZero;
        case 6:
            return CGPointZero;
        case 7:
            return CGPointZero;
        default:
            return CGPointZero;
    }
}

- (void)_drawLineInContext:(CGContextRef)ctx from:(CGPoint)pointA to:(CGPoint)pointB {
    CGContextSaveGState(ctx);
    CGContextSetFillColorWithColor(ctx, [UIColor blackColor].CGColor);
    CGContextSetLineWidth(ctx, self.lineWidth);
    CGContextMoveToPoint(ctx, pointA.x, pointA.y);
    CGContextAddLineToPoint(ctx, pointB.x, pointB.y);
    CGContextStrokePath(ctx);
    CGContextRestoreGState(ctx);
}

+ (BOOL)needsDisplayForKey:(NSString *)key {
    if ([key isEqualToString:@"step"]){
        return YES;
    }
    
    return [super needsDisplayForKey:key];
}

- (id<CAAction>)actionForKey:(NSString *)event {
    if ([event isEqualToString:@"step"]){
        CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:event];
        return animation;
    }
    
    return [super actionForKey:event];
}

@end

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
            self->_animatedLayer.color = self.color;
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
