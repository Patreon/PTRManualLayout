#import "ViewController.h"

#import <PTRManualLayout/PTRManualLayout.h>

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
  PTRMLLayout *layout = [PTRMLLayout layoutWithBounds:CGRectMake(100, 100, 100, 100)];
  layout.transform = CGAffineTransformMakeTranslation(40, 100);

  layout[_leftView].left = 20;
  layout[_leftView].right = 40;
  layout[_leftView].top = 50;
  layout[_leftView].height = 100;

  layout[_rightView].topLeft = layout.bounds.topLeft;
  layout[_rightView].size = layout.bounds.size;

  [layout apply];
}

@end
