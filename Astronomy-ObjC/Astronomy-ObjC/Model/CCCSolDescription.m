//
//  CCCSolDescription.m
//  Astronomy-ObjC
//
//  Created by Jonalynn Masters on 1/27/20.
//  Copyright © 2020 Jonalynn Masters. All rights reserved.
//

#import "CCCSolDescription.h"

@implementation NSObject (CCCSolDescription)

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
if (self = [super init]) {
    _sol = dictionary[@"sol"];
    _totalPhotos = dictionary[@"total_photos"];
    _cameras = dictionary[@"cameras"];
    }
    return self;
}


@end
