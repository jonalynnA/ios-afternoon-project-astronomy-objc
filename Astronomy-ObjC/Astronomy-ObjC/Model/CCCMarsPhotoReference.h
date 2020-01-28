//
//  CCCMarsPhotoReference.h
//  Astronomy-ObjC
//
//  Created by Jonalynn Masters on 1/27/20.
//  Copyright © 2020 Jonalynn Masters. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Camera;
@interface NSObject (CCCMarsPhotoReference)

@property (nonnull) NSNumber *refernceId;
@property (nonnull) NSNumber *sol;
@property (nonnull) Camera *camera;

@property (nonnull) NSDate *earthDate;
@property (nonnull) NSURL *imageURL;

- (instancetype)initWithDictionary:(NSDictionary *_Nonnull)dictionary;
@end


