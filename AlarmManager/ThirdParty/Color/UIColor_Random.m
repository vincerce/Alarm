
///
//
///

#import "UIColor_Random.h"

@implementation UIColor(Random)

//return a shared instance of UIColor
//create random color
+ (UIColor *)randomColor {
	
    CGFloat red = arc4random() % 256 / 255.0;
	CGFloat green = arc4random() % 256 / 255.0;
	CGFloat blue = arc4random() % 256 / 255.0;
	return [UIColor colorWithRed:red green:green blue:blue alpha:1.0f];
}

@end