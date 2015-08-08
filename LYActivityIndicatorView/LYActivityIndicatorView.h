//
//  Created by Carlos Vidal on 06/08/2015.
//  Copyright (c) 2015 Lyst Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

IB_DESIGNABLE
@interface LYActivityIndicatorView : UIView

@property (nonatomic, strong) IBInspectable UIColor *color;
@property (nonatomic, assign) IBInspectable CGFloat lineWidth;
@property (nonatomic, assign, readonly) BOOL isAnimating;

- (void)startAnimating;
- (void)stopAnimating;

@end
