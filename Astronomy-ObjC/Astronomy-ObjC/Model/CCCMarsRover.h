//
//  CCCMarsRover.h
//  Astronomy-ObjC
//
//  Created by Jonalynn Masters on 1/27/20.
//  Copyright © 2020 Jonalynn Masters. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CCCSolDescription.h"


@interface CCCMarsRover : NSObject

@property NSString *name;
@property NSDate *launchDate;
@property NSDate *landingDate;
@property NSString *status;
@property NSNumber *maxSol;
@property NSDate *maxDate;
@property NSNumber *numberOfPhotos;
@property NSArray<CCCSolDescription *> *solDescriptions;
@property (nonatomic) NSDateFormatter *dateFormatter;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end

