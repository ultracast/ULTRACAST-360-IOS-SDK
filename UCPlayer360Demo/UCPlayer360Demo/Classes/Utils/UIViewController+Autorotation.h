//
//  UIViewController+Autorotation.h
//  UCPlayer360Demo
//
//  Created by Ultracast on 2/1/17.
//  Copyright © 2017 Ultracast. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol UIViewControllerAutorotation <NSObject>

- (UIInterfaceOrientationMask)interfaceOrientationMask;

@optional
- (BOOL)canAutoRotate;

@end

@interface UIViewController (Autorotation)

- (UIInterfaceOrientationMask)defaultOrientation;

@end
