# ManualLayout

[![CI Status](http://img.shields.io/travis/Patreon/ManualLayout.svg?style=flat)](https://travis-ci.org/Patreon/ManualLayout)
[![Version](https://img.shields.io/cocoapods/v/ManualLayout.svg?style=flat)](http://cocoapods.org/pods/ManualLayout)
[![License](https://img.shields.io/cocoapods/l/ManualLayout.svg?style=flat)](http://cocoapods.org/pods/ManualLayout)
[![Platform](https://img.shields.io/cocoapods/p/ManualLayout.svg?style=flat)](http://cocoapods.org/pods/ManualLayout)

Layout your UIs in code. No tricks, no funny business, just dead simple layout.


## Table of Contents

1. [Example](#example)
2. [Installation](#installation)
3. [Usage](#usage)


## Usage

1. `#import <PTRManualLayout/PTRManualLayout.h>`
2. Build your layout, typically in `layoutSubviews`, by mapping your views to `PTRMLRects` (see [Example](#example) below)
3. `[layout apply]` to make all your dreams come true


## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

```
#import "ExampleView.h"
#import <PTRManualLayout/PTRManualLayout.h>

@interface ExampleView ()
@property (nonatomic, strong) UILabel *prompt;
@property (nonatomic, strong) UIButton *button;
@end

@implementation ExampleView

- (instancetype)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {
    self.prompt = [[UILabel alloc] initWithFrame:CGRectZero];
    self.prompt.text = @"PTRManualLayout lets you lay out your views with ease";
    [self addSubview:self.prompt];

    self.button = [[UIButton alloc] initWithFrame:CGRectZero];
    [self.button setTitle:@"Learn More"
                 forState:UIControlStateNormal];
    [self addSubview:self.button];
  }
  return self;
}

- (void)layoutSubviews {
  [super layoutSubviews];
  [[self buildLayout:self.bounds.size] apply];
}

- (CGSize)sizeThatFits:(CGSize)size {
  return [[self buildLayout:size] containingRect].size;
}

- (PTRMLLayout *)buildLayout:(CGSize)size {
  PTRMLLayout *layout = [MLLayout layoutWithBounds:(CGRect){CGPointZero, size}];

  CGFloat padding = 10;
  PTRMLLayout *insetRect = [PTRMLLayout rectWithCGRect:CGRectInset(layout.bounds.frame, padding, padding)];

  layout[self.prompt].size = [self.prompt sizeThatFits:insetRect.size];
  layout[self.prompt].centerX = insetRect.centerX;

  layout[self.button].size = [self.button sizeThatFits:insetRect.size];
  layout[self.button].centerX = insetRect.centerX;

  CGFloat totalHeightWithPadding = layout[self.prompt].height + padding + layout[self.button].height;
  layout[self.prompt].top = insetRect.centerY - (totalHeightWithPadding / 2);
  layout[self.button].bottom = insetRect.centerY + (totalHeightWithPadding / 2);

  return layout;
}

@end
```

## Installation

PTRMLLayout is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "PTRManualLayout"
```

## Author

David Kettler, david@patreon.com
Sam Morrison, samo@patreon.com

## License

PTRManualLayout is available under the Apache 2.0 license. See the LICENSE file for more info.
