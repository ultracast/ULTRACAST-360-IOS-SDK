//
//  PlayerViewController.h
//  UCPlayer360Demo
//
//  Created by Ultracast on 2/1/17.
//  Copyright © 2017 Ultracast. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PlayerViewController : UIViewController

+ (NSString *)storyboardIdentifier;

- (void)configureWithVideoURL:(NSURL *)videoURL;

@end
