//
//  MLLayout.h
//  ManualLayout
//
//  Created by Sam Morrison on 12/10/14.
//  Copyright (c) 2014 Patreon. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "MLRect.h"

@interface MLLayout : NSObject

@property (nonatomic, strong) MLRect *bounds;
@property (nonatomic, assign) CGAffineTransform transform;

+ (instancetype)layout;
+ (instancetype)layoutWithBounds:(CGRect)bounds;

- (MLRect *)objectForKeyedSubscript:(UIView *)key;
- (void)setObject:(MLRect *)obj forKeyedSubscript:(UIView *)key;

- (void)apply;

@end
