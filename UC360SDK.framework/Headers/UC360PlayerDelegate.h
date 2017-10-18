//
//  UC360PlayerDelegate.h
//  UC360SDK
//
//  Created by UltraCast on 14.02.17.
//  Copyright © 2017 UltraCast. All rights reserved.
//

#ifndef UC360PlayerDelegate_h
#define UC360PlayerDelegate_h

@class UC360PlayerViewController;

/*! Delegate for responding to playback events. */
@protocol UC360PlayerDelegate <NSObject>
@optional
- (void)uc360Player:(UC360PlayerViewController *)player stateChanged:(UC360PlayerPlaybackState)state;
- (void)uc360Player:(UC360PlayerViewController *)player playbackError:(UC360Error *)error;
- (void)uc360Player:(UC360PlayerViewController *)player networkError:(NSError *)error;
- (void)uc360Player:(UC360PlayerViewController *)player didUpdateLoadedTimeRange:(float)duration;
@end

#endif /* UC360PlayerDelegate_h */
