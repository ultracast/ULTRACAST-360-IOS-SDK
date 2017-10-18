//
//  UC360OrientationHelper.h
//  UC360SDK
//
//  Created by UltraCast on 14.02.17.
//  Copyright © 2017 UltraCast. All rights reserved.
//

#import <Foundation/Foundation.h>

@import UIKit;

#define NtfOrientationChanged @"NtfOrientationChanged"

@interface UC360OrientationHelper : NSObject

+ (UC360OrientationHelper *)sharedInstance;
+ (UIInterfaceOrientation)deviceToInterfaceOrientation:(UIDeviceOrientation)orientation;

@property (assign, nonatomic) UIInterfaceOrientation sbOrientation;
@property (assign, nonatomic) UIDeviceOrientation deviceOrientation;

- (void)startObserving;
- (void)rotateToPortraitOrientation;

@end
