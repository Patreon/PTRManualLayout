# ManualLayout

Layout your UIs in code. No tricks, no funny business, just dead simple layout.

#Table of Contents

1. [Installation](#installation)
2. [Usage](#usage)
3. [Example](#example)

#Installation

###[Cocoapods](https://github.com/CocoaPods/CocoaPods)

Add the following line in your `Podfile`:

```
pod 'ManualLayout', :git => 'git@github.com:Patreon/ManualLayout.git'
```

and run `pod install`


#Usage

1. `#import <ManualLayout/ManualLayout.h>`
2. Build your layout, typically in `layoutSubviews`, by mapping your views to `MLRects` (see [Example](#example) below)
3. `[layout apply]` to make all your dreams come true


#Example

```objc
#import "ExampleView.h"
#import <ManualLayout/ManualLayout.h>

@interface ExampleView ()
@property (nonatomic, strong) UILabel *prompt;
@property (nonatomic, strong) UIButton *button;
@end

@implementation ExampleView

- (instancetype)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {
    self.prompt = [[UILabel alloc] initWithFrame:CGRectZero];
    self.prompt.text = @"ManualLayout lets you lay out your views with ease";
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

- (MLLayout *)buildLayout:(CGSize)size {
  MLLayout *layout = [MLLayout layoutWithBounds:(CGRect){CGPointZero, size}];

  CGFloat padding = 10;
  MLRect *insetRect = [MLRect rectWithCGRect:CGRectInset(layout.bounds.frame, padding, padding)];

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
