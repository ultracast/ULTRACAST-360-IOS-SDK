//
//  UC360PlayerPlaybackState.h
//  UC360SDK
//
//  Created by UltraCast on 10.02.17.
//  Copyright © 2017 UltraCast. All rights reserved.
//

#ifndef UC360PlayerPlaybackState_h
#define UC360PlayerPlaybackState_h

/*!
 @typedef UC360PlayerPlaybackState
 @brief Types for player playback state.
 */

typedef NS_ENUM(NSInteger, UC360PlayerPlaybackState) {
    /** Default state after creation*/
    UC360PlayerPlaybackStateUnknown,
    
    /** Occurs after "updateVideoURL:" is invoked and before any data is being loaded.*/
    UC360PlayerPlaybackStatePrepearing,
    
    /** Occurs when player is ready to play file*/
    UC360PlayerPlaybackStateReadyToPlay,
    
    /** Occurs when player is starts to loading of media data.*/
    UC360PlayerPlaybackStateLoading,
    
    /** Occurs when player is starts to playing.*/
    UC360PlayerPlaybackStatePlaying,
    
    /** Occurs when player has played file to the end.*/
    UC360PlayerPlaybackStateFinished,
    
    /** Occurs after "stop" is invoked*/
    UC360PlayerPlaybackStateStopped
};

#endif /* UC360PlayerPlaybackState_h */
