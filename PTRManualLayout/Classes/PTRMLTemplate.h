#import <UIKit/UIKit.h>

#import "PTRMLLayout.h"

@interface PTRMLTemplate : NSObject

@property (nonatomic, assign) CGAffineTransform transform;

- (PTRMLRect *)objectForKeyedSubscript:(NSString *)key;
- (void)setObject:(PTRMLRect *)obj forKeyedSubscript:(NSString *)key;

- (void)bindKey:(NSString *)key toView:(UIView *)view;

- (PTRMLLayout *)layout;
- (PTRMLLayout *)layoutForViews:(NSDictionary *)viewMap;

@end
