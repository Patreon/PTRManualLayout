//
//  MLLayout.m
//  ManualLayout
//
//  Created by Sam Morrison on 12/10/14.
//  Copyright (c) 2014 Patreon. All rights reserved.
//

#import "MLLayout.h"

#import "MLRect.h"

@implementation MLLayout {
  NSMapTable *_map;
}

+ (instancetype)layout {
  return [[MLLayout alloc] init];
}

- (instancetype)init {
  if (self = [super init]) {
    _map = [NSMapTable mapTableWithKeyOptions:NSPointerFunctionsStrongMemory
                                 valueOptions:NSPointerFunctionsStrongMemory];
  }

  return self;
}

- (MLRect *)objectForKeyedSubscript:(UIView *)key {
  MLRect *rect = [_map objectForKey:key];

  if (!rect) {
    rect = [[MLRect alloc] init];
    [_map setObject:rect forKey:key];
  }

  return rect;
}

- (void)setObject:(MLRect *)obj forKeyedSubscript:(UIView *)key {
  [_map setObject:obj forKey:key];
}

- (void)apply {
}

@end
