//
//  CCMarsPhotoReference.m
//  Astronomy-ObjC
//
//  Created by Jonalynn Masters on 1/27/20.
//  Copyright © 2020 Jonalynn Masters. All rights reserved.
//

#import "CCCMarsPhotoReference.h"

@implementation CCCMarsPhotoReference

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    if (self = [super init]) {
        _refernceId = dictionary[@"id"];
        _sol = dictionary[@"sol"];
        NSDictionary *cameraDictionary = dictionary[@"camera"];

        NSNumber *cameraId = cameraDictionary[@"id"];
        NSString *name = cameraDictionary[@"name"];
        NSNumber *cameraRoverId = cameraDictionary[@"rover_id"];
        NSString *cameraFullName = cameraDictionary[@"full_name"];

        _camera = [[Camera alloc] initWithId:[cameraId intValue] name:name roverId:[cameraRoverId intValue] fullName:cameraFullName];

        _earthDate = dictionary[@"earth_date"];
        _imageURL = dictionary[@"img_src"];
    }
    return self;
}

@end
