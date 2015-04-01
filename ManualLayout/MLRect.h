//
//  MLRect.h
//  ManualLayout
//
//  Created by Sam Morrison on 12/10/14.
//  Copyright (c) 2014 Patreon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>

@interface MLRect : NSObject

+ (MLRect *)rect;
+ (MLRect *)rectWithCGRect:(CGRect)rect;

@property (nonatomic, assign) CGRect frame;
@property (nonatomic, assign) CGPoint center;
@property (nonatomic, assign) CGSize size;

@property (nonatomic, assign) CGFloat x;
@property (nonatomic, assign) CGFloat y;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) CGFloat left;
@property (nonatomic, assign) CGFloat right;
@property (nonatomic, assign) CGFloat top;
@property (nonatomic, assign) CGFloat bottom;
@property (nonatomic, assign) CGFloat centerX;
@property (nonatomic, assign) CGFloat centerY;

// uses self.view.font if defined, otherwise returns bottom
@property (nonatomic, assign) CGFloat baseline;

@property (nonatomic, assign) CGPoint topLeft;
@property (nonatomic, assign) CGPoint topRight;
@property (nonatomic, assign) CGPoint bottomLeft;
@property (nonatomic, assign) CGPoint bottomRight;

@property (nonatomic, weak) UIView *view;

@end
