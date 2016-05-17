//
//  MLLayout.m
//  ManualLayout
//
//  Created by Sam Morrison on 12/10/14.
//  Copyright (c) 2014 Patreon. All rights reserved.
//

#import "MLLayout.h"

#import "MLRect.h"

#ifndef CGFLOAT_CEIL
#ifdef CGFLOAT_IS_DOUBLE
#define CGFLOAT_CEIL(value) ceil(value)
#define CGFLOAT_FLOOR(value) floor(value)
#else
#define CGFLOAT_CEIL(value) ceil(value)
#define CGFLOAT_FLOOR(value) floorf(value)
#endif
#endif

@implementation MLLayout {
  NSMapTable *_map;
}

+ (instancetype)layout {
  return [[MLLayout alloc] init];
}

+ (instancetype)layoutWithBounds:(CGRect)bounds {
  MLLayout *layout = [[MLLayout alloc] init];
  layout.bounds.topLeft = bounds.origin;
  layout.bounds.size = bounds.size;
  return layout;
}

- (instancetype)init {
  if (self = [super init]) {
    _map = [NSMapTable mapTableWithKeyOptions:NSPointerFunctionsStrongMemory
                                 valueOptions:NSPointerFunctionsStrongMemory];
    _bounds = [MLRect rect];
    _transform = CGAffineTransformIdentity;
  }

  return self;
}

- (MLRect *)objectForKeyedSubscript:(UIView *)key {
  MLRect *rect = [_map objectForKey:key];

  if (!rect) {
    rect = [[MLRect alloc] init];
    rect.view = key;
    [_map setObject:rect forKey:key];
  }

  return rect;
}

- (void)setObject:(MLRect *)obj forKeyedSubscript:(UIView *)key {
  [_map setObject:obj forKey:key];
}

- (CGRect)containingRect {
  CGRect rect = CGRectZero;
  for (MLRect *mlrect in _map.objectEnumerator) {
    rect = CGRectUnion(rect, mlrect.frame);
  }
  return rect;
}

- (void)translate:(CGPoint)distance {
  CGAffineTransform transform = CGAffineTransformMakeTranslation(distance.x, distance.y);
  for (MLRect *rect in _map) {
    rect.topLeft = CGPointApplyAffineTransform(rect.topLeft, transform);
  }
}

- (void)apply {
  CGFloat scale = [UIScreen mainScreen].scale;
  for (UIView *view in _map.keyEnumerator) {
    CGRect rect = self[view].frame;
    rect = CGRectApplyAffineTransform(rect, _transform);
    rect.origin.x = CGFLOAT_FLOOR(rect.origin.x * scale) / scale;
    rect.origin.y = CGFLOAT_FLOOR(rect.origin.y * scale) / scale;
    rect.size.width = CGFLOAT_CEIL(rect.size.width * scale) / scale;
    rect.size.height = CGFLOAT_CEIL(rect.size.height * scale) / scale;
    view.frame = rect;
  }
}

@end
