//
//  CCCache.m
//  Astronomy-ObjC
//
//  Created by Jonalynn Masters on 1/27/20.
//  Copyright © 2020 Jonalynn Masters. All rights reserved.
//

#import "CCCCache.h"


@interface CCCCache ()


@property (nonatomic) NSCache *cache;

@end

@implementation CCCCache

- (instancetype)init
{
    self = [super init];
    if (self) {
        _cache = [[NSCache alloc] init];
    }
    return self;
}

- (void)cacheValueForKey:(NSString *)key value:(NSData *)value {
    if (value) {
        [self.cache setObject:value forKey:key];
    }
}

- (NSData *)valueForKey:(NSString *)key {
    return [self.cache objectForKey:key];
}
@end
