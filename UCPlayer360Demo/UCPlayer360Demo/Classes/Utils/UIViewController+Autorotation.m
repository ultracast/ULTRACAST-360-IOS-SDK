//
//  UIViewController+Autorotation.m
//  UCPlayer360Demo
//
//  Created by Ultracast on 2/1/17.
//  Copyright © 2017 Ultracast. All rights reserved.
//

#import "UIViewController+Autorotation.h"
#import "UIViewController+TopController.h"

@implementation UIViewController (Autorotation)

- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    UIViewController *vc = [UIViewController topViewController];
    if ([vc conformsToProtocol:@protocol(UIViewControllerAutorotation)] && [vc respondsToSelector:@selector(interfaceOrientationMask)]) {
        return [(NSObject <UIViewControllerAutorotation> *) vc interfaceOrientationMask];
    }
    return [self defaultOrientation];
}

- (UIInterfaceOrientationMask)defaultOrientation
{
    return UIInterfaceOrientationMaskAllButUpsideDown;
}

- (BOOL)shouldAutorotate
{
    UIViewController *vc = [UIViewController topViewController];
    if (vc != nil && [vc conformsToProtocol:@protocol(UIViewControllerAutorotation)] && [vc respondsToSelector:@selector(canAutoRotate)]) {
        return [(UIViewController<UIViewControllerAutorotation> *)vc canAutoRotate];
    }
    return YES;
}


@end
