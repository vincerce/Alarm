//
//  AdapterModel.m
//  Cook
//
//  Created by 0.0 on 15-4-24.
//  Copyright (c) 2015年 dingjun. All rights reserved.
//

#import "AdapterModel.h"

@implementation AdapterModel

//- (void)dealloc
//{
//    [super dealloc];
//}

+ (CGAdapter)getCGAdapter
{
    CGSize size = [UIScreen mainScreen].bounds.size;
    CGAdapter my;
    my.sWidth = size.width / 375.0f;
    my.sHeight = size.height / 667.0f;
    
    
    
    
    
    return my;
}

@end
