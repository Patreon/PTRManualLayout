//
//  ViewController.m
//  ManualLayoutExample
//
//  Created by Sam Morrison on 12/15/14.
//  Copyright (c) 2014 Patreon. All rights reserved.
//

#import "ViewController.h"

#import <ManualLayout/ManualLayout.h>

@implementation ViewController {
  UIView *_leftView;
  UIView *_rightView;
}

- (void)loadView {
  UIView *view = [[UIView alloc] initWithFrame:CGRectZero];

  view.backgroundColor = [UIColor whiteColor];

  _leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
  _leftView.backgroundColor = [UIColor blueColor];
  _rightView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
  _rightView.backgroundColor = [UIColor redColor];

  [view addSubview:_leftView];
  [view addSubview:_rightView];

  self.view = view;
}

- (void)viewWillLayoutSubviews {
  MLLayout *layout = [MLLayout layout];

  layout[_leftView].left = 20;
  layout[_leftView].right = 40;
  layout[_leftView].top = 50;
  layout[_leftView].height = 100;

  layout[_rightView].topLeft = layout[_leftView].topRight;
  layout[_rightView].size = layout[_leftView].size;

  [layout apply];
}

@end
