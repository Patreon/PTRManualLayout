#import <UIKit/UIKit.h>

#import "PTRMLRect.h"

@interface PTRMLLayout : NSObject

@property (nonatomic, strong) PTRMLRect *bounds;
@property (nonatomic, assign) CGAffineTransform transform;

+ (instancetype)layout;
+ (instancetype)layoutWithBounds:(CGRect)bounds;

- (PTRMLRect *)objectForKeyedSubscript:(UIView *)key;
- (void)setObject:(PTRMLRect *)obj forKeyedSubscript:(UIView *)key;

- (CGRect)containingRect;

- (void)apply;

@end
