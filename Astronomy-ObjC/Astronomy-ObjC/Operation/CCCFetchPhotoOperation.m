//
//  CCCFetchPhotoOperation.m
//  Astronomy-ObjC
//
//  Created by Jonalynn Masters on 1/27/20.
//  Copyright © 2020 Jonalynn Masters. All rights reserved.
//

#import "CCCFetchPhotoOperation.h"
#import "CCCMarsPhotoReference.h"

@interface CCCFetchPhotoOperation ()

@property CCCMarsPhotoReference *photoReference;


//@property(atomic, assign, readwrite, getter=isExecuting) BOOL executing;
//@property(atomic, assign, readwrite, getter=isFinished) BOOL finished;
//@property(atomic, assign, readwrite, getter=isCancelled) BOOL cancelled;

- (NSURLSessionDataTask *)loadImageDataTask;

@end

@implementation CCCFetchPhotoOperation

@synthesize isExecuting = _isExecuting;
@synthesize isFinished = _isFinished;
@synthesize isCancelled = _isCancelled;

- (NSURLSessionDataTask *)loadImageDataTask {
   NSURLComponents *components = [NSURLComponents componentsWithURL:self.photoReference.imageURL resolvingAgainstBaseURL:YES];
    components.scheme = @"https";
    NSURL *securePhotoURL = components.URL;
    NSLog(@"secure photo url: %@", securePhotoURL);
    NSURLSessionDataTask *task = [[NSURLSession sharedSession] dataTaskWithURL:securePhotoURL completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        // Handle the responses (error vs. data)

        // Call the completion block as needed
        // check the errors
        
        if (error) {
            NSLog(@"Error fetching photo: %@", error);
            NSLog(@"operationfinished.");

            [self willChangeValueForKey:@"isExecuting"];
            [self willChangeValueForKey:@"isFinished"];

            _isExecuting = NO;
            _isFinished = YES;

            [self didChangeValueForKey:@"isExecuting"];
            [self didChangeValueForKey:@"isFinished"];
            return;
        }
        if (data) {
            self.imageData = data;
            NSLog(@"operationfinished.");

            [self willChangeValueForKey:@"isExecuting"];
            [self willChangeValueForKey:@"isFinished"];

            _isExecuting = NO;
            _isFinished = YES;

            [self didChangeValueForKey:@"isExecuting"];
            [self didChangeValueForKey:@"isFinished"];
            NSLog(@"finish state %d", self.isFinished);
        } else {
            NSLog(@"no data return on load image");
            NSLog(@"operationfinished.");

            [self willChangeValueForKey:@"isExecuting"];
            [self willChangeValueForKey:@"isFinished"];

            _isExecuting = NO;
            _isFinished = YES;

            [self didChangeValueForKey:@"isExecuting"];
            [self didChangeValueForKey:@"isFinished"];
            return;
        }
        
    }];
    return task;
}

//+ (BOOL)automaticallyNotifiesObserversForKey {
//  return YES;
//}
//
//+ (NSSet *)keyPathsForValuesAffectingIsCancelled {
//  NSSet *result = [NSSet setWithObject:@"cancelled"];
//  return result;
//}
//
//+ (NSSet *)keyPathsForValuesAffectingIsExecuting {
//  NSSet *result = [NSSet setWithObject:@"executing"];
//      return result;
//}
//
// + (NSSet *)keyPathsForValuesAffectingIsFinished {
//    NSSet *result = [NSSet setWithObject:@"finished"];
//   return result;
// }



- (void)start {
  //You can use self.executing = YES; (note we can change executing which would otherwise be read-only because we synthesized our own ivar.
    [self willChangeValueForKey:@"isExecuting"];
    _isExecuting = YES;
    [self didChangeValueForKey:@"isExecuting"];
    NSLog(@"start operation");
    [[self loadImageDataTask] resume];
}

- (void)cancel {
    _isCancelled = YES;
    [[self loadImageDataTask] cancel];
}


- (instancetype)initWithPhotoReference:(CCCMarsPhotoReference *)photoReference {
    if (self = [super init]) {
        _photoReference = photoReference;
    }
    return self;
}

- (BOOL)isAsynchronous {
    return YES;
}



@end
