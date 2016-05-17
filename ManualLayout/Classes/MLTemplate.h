//
//  MLTemplate.h
//  ManualLayout
//
//  Created by Sam Morrison on 1/30/15.
//  Copyright (c) 2015 Patreon. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "MLLayout.h"

@interface MLTemplate : NSObject

@property (nonatomic, assign) CGAffineTransform transform;

- (MLRect *)objectForKeyedSubscript:(NSString *)key;
- (void)setObject:(MLRect *)obj forKeyedSubscript:(NSString *)key;

- (void)bindKey:(NSString *)key toView:(UIView *)view;

- (MLLayout *)layout;
- (MLLayout *)layoutForViews:(NSDictionary *)viewMap;

@end
