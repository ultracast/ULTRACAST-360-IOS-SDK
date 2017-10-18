//
//  UC360Player.h
//  UC360SDK
//
//  Created by Ultracast on 2/1/17.
//  Copyright © 2017 Ultracast. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "UC360PlayerPlaybackState.h"
#import "UC360Error.h"
#import "UC360PlayerDelegate.h"
#import "UC360PlayerControlType.h"

@interface UC360PlayerViewController: UIViewController

@property (weak, nonatomic) NSObject<UC360PlayerDelegate> *delegate;

/*! Whether or not VR mode is on. */
@property (readonly, nonatomic) BOOL isVREnabled;

/*! Whether or not player is playing. */
@property (readonly, nonatomic) BOOL isPlaying;

/*! Whether or not player is muted. */
@property (readonly, nonatomic) BOOL isMuted;

/*! Current playback time. */
@property (readonly, nonatomic) float playbackTime;

/*! Video duration. */
@property (readonly, nonatomic) float videoDuration;

/*! Player playback state. */
@property (readonly, nonatomic) UC360PlayerPlaybackState playbackState;

/*! Player controls type. */
@property (assign, nonatomic) UC360PlayerControlType controlsType;

/*!
 Configures player with new url.
 @param videoURL URL to video file as string.
 */
- (void)updateVideoURL:(NSURL*)videoURL;

/*!
 Initiates playback.
 */
- (void)play;

/*!
 Pauses playback.
 */
- (void)pause;

/*!
 Stops playback.
 */
- (void)stop;

/*!
 Seeks to time.
 @param time The time ins seconds.
 */
- (void)seek:(float)time;

/*!
 Seeks Enable/disable VR mode.
 @param enable If "enable==YES" then VR mode is on. If "enable==NO" then VR mode is off.
 */
- (void)enableVR:(BOOL)enable;

/*!
 Clean up routine. Call this method before destroying of class instance.
 */
- (void)cleanup;

/*!
 Mute sound
 */
- (void)mute:(BOOL)mute;

@end
