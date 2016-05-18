#import "PTRMLRect.h"
#import <UIKit/UIFont.h>

#define BIND_CONSTRAINT_FLOAT(getter, setter, constraint) \
  - (CGFloat)getter { \
    return constraint; \
  }; \
  - (void)setter:(CGFloat)value { \
    constraint = value; \
  };

#define BIND_CONSTRAINT_POINT(getter, setter, constraintA, constraintB) \
  - (CGPoint)getter { \
    return CGPointMake(constraintA, constraintB); \
  }; \
  - (void)setter:(CGPoint)point { \
    constraintA = point.x; \
    constraintB = point.y; \
  };

typedef NS_ENUM (NSUInteger, ValueConstraint) {
  ValueConstraintNone = 0,
  ValueConstraintA = 1 << 1,
  ValueConstraintB = 1 << 2,
  ValueConstraintCenter = 1 << 3,
  ValueConstraintSize = 1 << 4,
};

@interface Constraint : NSObject

@property (nonatomic, assign) CGFloat a;
@property (nonatomic, assign) CGFloat b;
@property (nonatomic, assign) CGFloat center;
@property (nonatomic, assign) CGFloat size;

@end

@implementation PTRMLRect {
  Constraint *_xConstraint;
  Constraint *_yConstraint;
}

+ (PTRMLRect *)rect {
  return [[PTRMLRect alloc] init];
}

+ (PTRMLRect *)rectWithCGRect:(CGRect)rect {
  PTRMLRect *mlRect = [[PTRMLRect alloc] init];
  mlRect.topLeft = rect.origin;
  mlRect.size = rect.size;
  return mlRect;
}

- (instancetype)init {
  if (self = [super init]) {
    _xConstraint = [[Constraint alloc] init];
    _yConstraint = [[Constraint alloc] init];
  }

  return self;
}

- (CGRect)frame {
  return CGRectMake(_xConstraint.a, _yConstraint.a, _xConstraint.size, _yConstraint.size);
}

- (void)setFrame:(CGRect)frame {
  self.topLeft = frame.origin;
  self.size = frame.size;
}

- (CGPoint)center {
  return CGPointMake(_xConstraint.center, _yConstraint.center);
}

- (void)setCenter:(CGPoint)center {
  _xConstraint.center = center.x;
  _yConstraint.center = center.y;
}

- (CGSize)size {
  return CGSizeMake(_xConstraint.size, _yConstraint.size);
}

- (void)setSize:(CGSize)size {
  _xConstraint.size = size.width;
  _yConstraint.size = size.height;
}

- (CGFloat)baseline {
  if ([self.view respondsToSelector:@selector(font)]) {
    UIFont *font = [self.view performSelector:@selector(font)];
    return self.top + font.ascender;
  } else {
    return self.bottom;
  }
}

- (void)setBaseline:(CGFloat)baseline {
  if ([self.view respondsToSelector:@selector(font)]) {
    UIFont *font = [self.view performSelector:@selector(font)];
    self.top = baseline - font.ascender;
  } else {
    self.bottom = baseline;
  }
}

BIND_CONSTRAINT_FLOAT(x, setX, _xConstraint.a)
BIND_CONSTRAINT_FLOAT(left, setLeft, _xConstraint.a)
BIND_CONSTRAINT_FLOAT(right, setRight, _xConstraint.b)
BIND_CONSTRAINT_FLOAT(width, setWidth, _xConstraint.size)
BIND_CONSTRAINT_FLOAT(centerX, setCenterX, _xConstraint.center)

BIND_CONSTRAINT_FLOAT(y, setY, _yConstraint.a)
BIND_CONSTRAINT_FLOAT(top, setTop, _yConstraint.a)
BIND_CONSTRAINT_FLOAT(bottom, setBottom, _yConstraint.b)
BIND_CONSTRAINT_FLOAT(height, setHeight, _yConstraint.size)
BIND_CONSTRAINT_FLOAT(centerY, setCenterY, _yConstraint.center)

BIND_CONSTRAINT_POINT(topLeft, setTopLeft, _xConstraint.a, _yConstraint.a)
BIND_CONSTRAINT_POINT(topRight, setTopRight, _xConstraint.b, _yConstraint.a)
BIND_CONSTRAINT_POINT(bottomLeft, setBottomLeft, _xConstraint.a, _yConstraint.b)
BIND_CONSTRAINT_POINT(bottomRight, setBottomRight, _xConstraint.b, _yConstraint.b)

@end

#define BIND_VALUE(var, getter, setter, constraint) \
  - (CGFloat)getter { \
    if (_resolved || _constraints & constraint) { \
      return var; \
    } \
    assert(NO); \
    return 0; \
  } \
  - (void)setter:(CGFloat)value { \
    if (!(_constraints & constraint)) { \
      _numConstraints++; \
      _constraints |= constraint; \
    } else { \
      _resolved = NO; \
    } \
    var = value; \
    if (!_resolved && _numConstraints == 2) { \
      [self resolve]; \
    } \
  }

@implementation Constraint {
  BOOL       _resolved;
  NSUInteger _constraints;
  NSInteger  _numConstraints;

  CGFloat _a;
  CGFloat _b;
  CGFloat _center;
  CGFloat _size;
}

BIND_VALUE(_a, a, setA, ValueConstraintA)
BIND_VALUE(_b, b, setB, ValueConstraintB)
BIND_VALUE(_center, center, setCenter, ValueConstraintCenter)
BIND_VALUE(_size, size, setSize, ValueConstraintSize)

- (void)resolve {
  switch (_constraints) {
  case ValueConstraintA | ValueConstraintB:
    _center = _a + (_b - _a) / 2;
    _size = _b - _a;
    break;

  case ValueConstraintA | ValueConstraintCenter:
    _size = 2 * (_center - _a);
    _b = _a + _size;
    break;

  case ValueConstraintA | ValueConstraintSize:
    _b = _a + _size;
    _center = _a + _size / 2;
    break;

  case ValueConstraintB | ValueConstraintCenter:
    _size = 2 * (_b - _center);
    _a = _b - _size;
    break;

  case ValueConstraintB | ValueConstraintSize:
    _a = _b - _size;
    _center = _a + _size / 2;
    break;

  case ValueConstraintCenter | ValueConstraintSize:
    _a = _center - _size / 2;
    _b = _center + _size / 2;
    break;

  default:
    assert(NO);
    break;
  }

  _resolved = YES;
}

@end
