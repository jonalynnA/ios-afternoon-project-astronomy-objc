//
//  CCCFetchPhotoOperation.h
//  Astronomy-ObjC
//
//  Created by Jonalynn Masters on 1/27/20.
//  Copyright © 2020 Jonalynn Masters. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CCCMarsPhotoReference;


@interface CCCFetchPhotoOperation : NSOperation
@property NSData *imageData;
- (instancetype)initWithPhotoReference:(CCCMarsPhotoReference *)photoReference;
@property (nonatomic) BOOL isExecuting;
@property (nonatomic) BOOL isFinished;
@property (nonatomic) BOOL isCancelled;

@end

