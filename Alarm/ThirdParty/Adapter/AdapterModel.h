//
//  AdapterModel.h
//  Cook
//
//  Created by 0.0 on 15-4-24.
//  Copyright (c) 2015年 dingjun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef struct shipei {
    CGFloat sWidth;
    CGFloat sHeight;
}CGAdapter;

@interface AdapterModel : NSObject

+ (CGAdapter)getCGAdapter;

@end
