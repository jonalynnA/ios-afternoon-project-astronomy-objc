//
//  CCCSolDescription.h
//  Astronomy-ObjC
//
//  Created by Jonalynn Masters on 1/27/20.
//  Copyright © 2020 Jonalynn Masters. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface CCCSolDescription : NSObject

@property (nonnull) NSNumber *sol;
@property (nonnull) NSNumber *totalPhotos;
@property (nonnull) NSArray<NSString *> *cameras;

- (instancetype)initWithDictionary:(NSDictionary *_Nonnull)dictionary;
@end


