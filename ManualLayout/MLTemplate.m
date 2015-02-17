//
//  MLTemplate.m
//  ManualLayout
//
//  Created by Sam Morrison on 1/30/15.
//  Copyright (c) 2015 Patreon. All rights reserved.
//

#import "MLTemplate.h"

@implementation MLTemplate {
  NSMapTable          *_map;
  NSMutableDictionary *_views;
}

- (instancetype)init {
  if (self = [super init]) {
    _map = [NSMapTable mapTableWithKeyOptions:NSPointerFunctionsStrongMemory
                                 valueOptions:NSPointerFunctionsStrongMemory];
    _views = [NSMutableDictionary dictionary];
  }

  return self;
}

- (MLRect *)objectForKeyedSubscript:(NSString *)key {
  MLRect *rect = [_map objectForKey:key];

  if (!rect) {
    rect = [[MLRect alloc] init];
    [_map setObject:rect forKey:key];
  }

  return rect;
}

- (void)setObject:(MLRect *)obj forKeyedSubscript:(NSString *)key {
  [_map setObject:obj forKey:key];
}

- (void)bindKey:(NSString *)key toView:(UIView *)view {
  _views[key] = view;
}

- (MLLayout *)layout {
  MLLayout *layout = [MLLayout layout];
  layout.transform = _transform;

  for (NSString *key in _views.keyEnumerator) {
    layout[_views[key]] = self[key];
  }

  return layout;
}

- (MLLayout *)layoutForViews:(NSDictionary *)viewMap {
  MLLayout *layout = [self layout];

  for (NSString *key in _views.keyEnumerator) {
    layout[viewMap[key]] = self[key];
  }

  return layout;
}

@end
