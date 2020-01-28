//
//  CCCCache.h
//  Astronomy-ObjC
//
//  Created by Jonalynn Masters on 1/27/20.
//  Copyright © 2020 Jonalynn Masters. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CCCCache: NSCache
- (void)cacheValueForKey:(NSString * _Nonnull)key value:(NSData * _Nonnull)value;
- (NSData * _Nullable)valueForKey:(NSString * _Nonnull)key;

@end
