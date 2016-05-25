//
//  NKOActivityIndicatorLayer.m
//  NKOActivityIndicatorView
//
//  Created by Carlos Vidal Pallin on 07/08/2015.
//  Copyright (c) 2015 Carlos Vidal Pallin. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "NKOActivityIndicatorLayer.h"

CGFloat const kSegmentLapse = 0.125f;

@interface NKOActivityIndicatorLayer ()

@end

@implementation NKOActivityIndicatorLayer

- (instancetype)init {
    self = [super init];
    
    if (self != nil) {
        self.needsDisplayOnBoundsChange = YES;
    }
    
    return self;
}

- (instancetype)initWithLayer:(id)layer {
    self = [super initWithLayer:layer];
    
    if (self != nil) {
        NKOActivityIndicatorLayer *sourceLayer = layer;
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

#pragma mark - Private methods

- (void)_drawSpinInContext:(CGContextRef)ctx withStep:(CGFloat)step {
    static NSUInteger segments = 8;
    
    for (int segment = 0; segment <= segments; segment++) {
        if (segment < segments*0.5f && step/kSegmentLapse >= segments*0.5f) {
            continue;
        }
        else if (step >= kSegmentLapse*segment || step > 0.5f) {
            CGPoint pointA = [self _pointAforSegment:segment step:step];
            CGPoint pointB = [self _pointBforSegment:segment step:step];
            [self _drawLineInContext:ctx from:pointA to:pointB];
        }
    }
}

- (CGPoint)_pointAforSegment:(NSUInteger)segment step:(CGFloat)step {
    CGFloat pos = step < (kSegmentLapse*(segment+1)) ? (step - kSegmentLapse*(segment))/kSegmentLapse : 1.f;
    CGFloat width = CGRectGetWidth(self.bounds);
    CGFloat height = CGRectGetWidth(self.bounds);
    
    switch (segment) {
        case 0:  return CGPointMake(0.f, 0.f);
        case 1:  return CGPointMake(width, 0.f);
        case 2:  return CGPointMake(width, height);
        case 3:  return CGPointMake(0.f, height);
        case 4:  return CGPointMake(width*pos, 0.f);
        case 5:  return CGPointMake(width, height*pos);
        case 6:  return CGPointMake(width-(width*pos), height);
        case 7:  return CGPointMake(0.f, height-(height*pos));
        default: return CGPointZero;
    }
}

- (CGPoint)_pointBforSegment:(NSUInteger)segment step:(CGFloat)step {
    CGFloat pos = step < (kSegmentLapse*(segment+1)) ? (step - kSegmentLapse*(segment))/kSegmentLapse : 1.f;
    CGFloat width = CGRectGetWidth(self.bounds);
    CGFloat height = CGRectGetWidth(self.bounds);
    
    switch (segment) {
        case 0:  return CGPointMake(width*pos, 0.f);
        case 1:  return CGPointMake(width, height*pos);
        case 2:  return CGPointMake(width-(width*pos), height);
        case 3:  return CGPointMake(0.f, height-(height*pos));
        case 4:  return CGPointMake(width, 0.f);
        case 5:  return CGPointMake(width, height);
        case 6:  return CGPointMake(0.f, height);
        case 7:  return CGPointMake(0.f, 0.f);
        default: return CGPointZero;
    }
}

- (void)_drawLineInContext:(CGContextRef)ctx from:(CGPoint)pointA to:(CGPoint)pointB {
    CGContextSaveGState(ctx);
    CGContextSetStrokeColorWithColor(ctx, self.color.CGColor);
    CGContextSetLineWidth(ctx, self.lineWidth);
    CGContextMoveToPoint(ctx, pointA.x, pointA.y);
    CGContextAddLineToPoint(ctx, pointB.x, pointB.y);
    CGContextStrokePath(ctx);
    CGContextRestoreGState(ctx);
}

#pragma mark - Overriden methods

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
