//
//  NKOActivityIndicatorLayer.h
//  NKOActivityIndicatorView
//
//  Created by Carlos Vidal Pallin on 07/08/2015.
//  Copyright (c) 2015 Carlos Vidal Pallin. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

@interface NKOActivityIndicatorLayer : CALayer

@property (nonatomic, assign) CGFloat step;

@property (nonatomic, assign) CGColorRef color;
@property (nonatomic, assign) CGFloat lineWidth;

@end
