//
//  CCCMarsRover.m
//  Astronomy-ObjC
//
//  Created by Jonalynn Masters on 1/27/20.
//  Copyright © 2020 Jonalynn Masters. All rights reserved.
//

#import "CCCMarsRover.h"

@interface CCCMarsRover()

@end

@implementation CCCMarsRover


- (void)setDateFormatter:(NSDateFormatter *)dateFormatter {
    self.dateFormatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
    self.dateFormatter.timeZone = [[NSTimeZone alloc] initWithName:@"GMT"];
    self.dateFormatter.dateFormat = @"yyyy-MM-dd";
}

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
if (self = [super init]) {
    _name = dictionary[@"name"];
    _launchDate = dictionary[@"launch_date"];
    _landingDate = dictionary[@"landing_date"];
    _status = dictionary[@"status"];
    _maxSol = dictionary[@"max_sol"];
    _maxDate = dictionary[@"max_date"];
    _numberOfPhotos = dictionary[@"total_photos"];
    NSArray *solDescriptionsArray = dictionary[@"photos"];
    NSMutableArray *solArray = [[NSMutableArray alloc] init];
    for (NSDictionary *solDictionary in solDescriptionsArray) {
        
        CCCSolDescription *solDescription = [[CCCSolDescription alloc] initWithDictionary:solDictionary];
        [solArray addObject:solDescription];
    }
    _solDescriptions = [solArray copy];
    }
    return self;
}

@end
