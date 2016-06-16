//
//  Jared_PageControl.m
//  Jared_Guide引导页
//
//  Created by Jared on 16/6/12.
//  Copyright © 2016年 Jared. All rights reserved.
//

#import "Jared_PageControl.h"

@interface Jared_PageControl (private)

- (void)setUpPage;
@end

@implementation Jared_PageControl

@synthesize imagePageStateNormal;
@synthesize imagePageStateHighlighted;

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    return self;
}

- (void)setImagePageStateNormal:(UIImage *)imagePageStateNormal{
    [self setUpPage];
}

- (void)setImagePageStateHighlighted:(UIImage *)imagePageStateHighlighted{
    [self setUpPage];
}

- (void)endTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event{
    [super endTrackingWithTouch:touch withEvent:event];
    [self setUpPage];
}

- (void)setUpPage{
//    if (imagePageStateHighlighted || imagePageStateNormal) {
        for (int i = 0; i < [self.subviews count]; i++) {
            UIImageView *dot = [self.subviews objectAtIndex:i];
            dot.image = self.currentPage == i ? imagePageStateNormal : imagePageStateHighlighted;
        }
    }
//}




@end
