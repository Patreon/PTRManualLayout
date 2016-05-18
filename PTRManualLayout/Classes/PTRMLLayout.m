#import "PTRMLLayout.h"

#import "PTRMLRect.h"

#ifndef CGFLOAT_CEIL
#ifdef CGFLOAT_IS_DOUBLE
#define CGFLOAT_CEIL(value) ceil(value)
#define CGFLOAT_FLOOR(value) floor(value)
#else
#define CGFLOAT_CEIL(value) ceil(value)
#define CGFLOAT_FLOOR(value) floorf(value)
#endif
#endif

@implementation PTRMLLayout {
  NSMapTable *_map;
}

+ (instancetype)layout {
  return [[PTRMLLayout alloc] init];
}

+ (instancetype)layoutWithBounds:(CGRect)bounds {
  PTRMLLayout *layout = [[PTRMLLayout alloc] init];
  layout.bounds.topLeft = bounds.origin;
  layout.bounds.size = bounds.size;
  return layout;
}

- (instancetype)init {
  if (self = [super init]) {
    _map = [NSMapTable mapTableWithKeyOptions:NSPointerFunctionsStrongMemory
                                 valueOptions:NSPointerFunctionsStrongMemory];
    _bounds = [PTRMLRect rect];
    _transform = CGAffineTransformIdentity;
  }

  return self;
}

- (PTRMLRect *)objectForKeyedSubscript:(UIView *)key {
  PTRMLRect *rect = [_map objectForKey:key];

  if (!rect) {
    rect = [[PTRMLRect alloc] init];
    rect.view = key;
    [_map setObject:rect forKey:key];
  }

  return rect;
}

- (void)setObject:(PTRMLRect *)obj forKeyedSubscript:(UIView *)key {
  [_map setObject:obj forKey:key];
}

- (CGRect)containingRect {
  CGRect rect = CGRectZero;
  for (PTRMLRect *PTRMLRect in _map.objectEnumerator) {
    rect = CGRectUnion(rect, PTRMLRect.frame);
  }
  return rect;
}

- (void)translate:(CGPoint)distance {
  CGAffineTransform transform = CGAffineTransformMakeTranslation(distance.x, distance.y);
  for (PTRMLRect *rect in _map) {
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
