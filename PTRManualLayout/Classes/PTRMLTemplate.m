#import "PTRMLTemplate.h"

@implementation PTRMLTemplate {
  NSMapTable          *_map;
  NSMutableDictionary *_views;
}

- (instancetype)init {
  if (self = [super init]) {
    _map = [NSMapTable mapTableWithKeyOptions:NSPointerFunctionsStrongMemory
                                 valueOptions:NSPointerFunctionsStrongMemory];
    _views = [NSMutableDictionary dictionary];
    _transform = CGAffineTransformIdentity;
  }

  return self;
}

- (PTRMLRect *)objectForKeyedSubscript:(NSString *)key {
  PTRMLRect *rect = [_map objectForKey:key];

  if (!rect) {
    rect = [[PTRMLRect alloc] init];
    [_map setObject:rect forKey:key];
  }

  return rect;
}

- (void)setObject:(PTRMLRect *)obj forKeyedSubscript:(NSString *)key {
  [_map setObject:obj forKey:key];
}

- (void)bindKey:(NSString *)key toView:(UIView *)view {
  _views[key] = view;
}

- (PTRMLLayout *)layout {
  PTRMLLayout *layout = [PTRMLLayout layout];
  layout.transform = _transform;

  for (NSString *key in _views.keyEnumerator) {
    layout[_views[key]] = self[key];
  }

  return layout;
}

- (PTRMLLayout *)layoutForViews:(NSDictionary *)viewMap {
  PTRMLLayout *layout = [self layout];

  for (NSString *key in _map.keyEnumerator) {
    layout[viewMap[key]] = self[key];
  }

  return layout;
}

@end
