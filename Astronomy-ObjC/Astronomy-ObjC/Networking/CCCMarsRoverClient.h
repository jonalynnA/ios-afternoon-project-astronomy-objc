//
//  CCCMarsRoverClient.h
//  Astronomy-ObjC
//
//  Created by Jonalynn Masters on 1/27/20.
//  Copyright © 2020 Jonalynn Masters. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CCCMarsRover;
@class CCCMarsPhotoReference;

typedef void (^CCCRoverCompletionBlock)(CCCMarsRover *, NSError *);
typedef void (^CCCPhotoReferenceCompletionBlock)(NSArray<CCCMarsPhotoReference *> *, NSError *);
typedef void (^CCCImageCompletionBlock)(NSData *, NSError *);

@interface CCCMarsRoverClient : NSObject
- (void)fetchMarsRoverWithName:(NSString *)name completionBlock:(CCCRoverCompletionBlock)completionBlock;
- (void)fetchPhotosFromRover:(CCCMarsRover *)rover onSol:(NSNumber *)sol completionBlock:(CCCPhotoReferenceCompletionBlock)completionBlock;
- (void)fetchImageFromPhotoURL:(NSURL *)photoURL completionBlock:(CCCImageCompletionBlock)completionBlock;

@end
