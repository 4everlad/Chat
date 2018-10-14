//
//  Themes.m
//  Chat
//
//  Created by Dmitry Bakulin on 12.10.2018.
//  Copyright © 2018 Dmitry Bakulin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Themes.h"
#import <UIKit/UIKit.h>


@implementation Themes

@synthesize theme1 = _theme1;
@synthesize theme2 = _theme2;
@synthesize theme3 = _theme3;

- (UIColor*) theme1 {
    return _theme1;
}

- (UIColor*) theme2 {
    return _theme2;
}

- (UIColor*) theme3 {
    return _theme3;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _theme1 = [UIColor redColor];
        _theme2 = [UIColor greenColor];
        _theme3 = [UIColor blueColor];
    }
    return self;
}

@end
