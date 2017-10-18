//
//  UIViewController+TopController.m
//  UCPlayer360Demo
//
//  Created by Ultracast on 2/1/17.
//  Copyright © 2017 Ultracast. All rights reserved.
//

#import "UIViewController+TopController.h"

@implementation UIViewController (TopController)

+ (UIViewController *)topViewController
{
    UIViewController *vc = [UIApplication sharedApplication].keyWindow.rootViewController;
    BOOL finished = NO;
    while (!finished) {
        if (vc.presentedViewController != nil) {
            vc = vc.presentedViewController;
        } else if ([vc isKindOfClass:[UINavigationController class]]) {
            vc = [(UINavigationController *)vc topViewController];
        }
        finished = vc.presentedViewController == nil && ![vc isKindOfClass:[UINavigationController class]];
    }
    
    return vc;
}

@end
