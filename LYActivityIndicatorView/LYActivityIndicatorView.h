//
//  Created by Carlos Vidal on 06/08/2015.
//  Copyright (c) 2015 Lyst Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LYActivityIndicatorView : UIView

@property (nonatomic, strong) UIColor *color;
@property (nonatomic, assign) CGFloat lineWidth;

- (void)startAnimating;
- (void)stopAnimating;

@end
