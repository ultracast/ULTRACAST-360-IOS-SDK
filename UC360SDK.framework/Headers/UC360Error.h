//
//  UC360Error.h
//  UC360SDK
//
//  Created by UltraCast on 14.02.17.
//  Copyright © 2017 UltraCast. All rights reserved.
//

#import <Foundation/Foundation.h>

FOUNDATION_EXPORT NSString *const UC360ErrorDomain;

typedef NS_ENUM(NSInteger, UC360ErrorCode) {
    UC360ErrorUnknown,
    UC360ErrorOutOfMemory,
    UC360ErrorMediaServicesWereReset,
    UC360ErrorDecodeFailed,
    UC360ErrorrInvalidSourceMedia,
    UC360ErrorFileFormatNotRecognized,
    UC360ErrorFileFailedToParse,
    UC360ErrorContentIsProtected,
    UC360ErrorNotFound ,
    UC360ErrorDecoderNotFound,
    UC360ErrorContentIsNotAuthorized,
    UC360ErrorApplicationIsNotAuthorized,
    UC360ErrorDecoderTemporarilyUnavailable,
    UC360ErrorIncompatibleAsset,
    UC360ErrorFailedToLoadMediaData,
    UC360ErrorServerIncorrectlyConfigured,
    UC360ErrorUndecodableMediaData
};

@interface UC360Error : NSError

- (UC360ErrorCode)uc360ErrorCode;

@end
