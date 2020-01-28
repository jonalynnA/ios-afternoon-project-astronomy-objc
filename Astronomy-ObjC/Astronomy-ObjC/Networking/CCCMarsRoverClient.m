//
//  CCCMarsRoverClient.m
//  Astronomy-ObjC
//
//  Created by Jonalynn Masters on 1/27/20.
//  Copyright © 2020 Jonalynn Masters. All rights reserved.
//

#import "CCCMarsRoverClient.h"
#import "CCCMarsRover.h"
#import "CCCMarsPhotoReference.h"

@implementation CCCMarsRoverClient

static NSString *baseURLString = @"https://api.nasa.gov/mars-photos/api/v1";
static NSString *apiKey = @"ONIRa0yMpU8rB2LMI2fxSntT6nzTpveGHZGESXdg";

- (void)fetchMarsRoverWithName:(NSString *)name completionBlock:(CCCRoverCompletionBlock)completionBlock {
    // Create API request

    // Setup the URL

    NSString *manifestString = [baseURLString stringByAppendingPathComponent:@"manifests"];
    NSString *curiosityString = [manifestString stringByAppendingPathComponent:name];


    NSURLComponents *urlComponents = [[NSURLComponents alloc] initWithString:curiosityString];



    // Query Parameters

    NSArray *queryItems = @[
                            [NSURLQueryItem queryItemWithName:@"api_key" value:apiKey]
                            ];

    urlComponents.queryItems = queryItems;

    NSURL *url = urlComponents.URL;
    NSLog(@"URL: %@", url);

    NSURLSessionDataTask *task = [[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {

        if (error) {
            NSLog(@"Error fetching marsRover: %@", error);
            completionBlock(nil, error);
            return;
        }

        NSError *jsonError = nil;
        NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
        if (jsonError) {
            NSLog(@"JSON Error: %@", jsonError);
            completionBlock(nil, jsonError);
            return;
        }

        NSLog(@"JSON: %@", json);

        NSDictionary *photoManifest = json[@"photo_manifest"];

        CCCMarsRover *rover = [[CCCMarsRover alloc] initWithDictionary:photoManifest];

        completionBlock(rover, nil);
    }];
    [task resume];

}

- (void)fetchPhotosFromRover:(CCCMarsRover *)rover onSol:(NSNumber *)sol completionBlock:(CCCPhotoReferenceCompletionBlock)completionBlock {

    NSString *roversString = [baseURLString stringByAppendingPathComponent:@"rovers"];
    NSString *roverNameString = [roversString stringByAppendingPathComponent:rover.name];
    NSString *photosString = [roverNameString stringByAppendingPathComponent:@"photos"];


    NSURLComponents *urlComponents = [[NSURLComponents alloc] initWithString:photosString];



      // Query Parameters

      NSArray *queryItems = @[
                            [NSURLQueryItem queryItemWithName:@"sol" value:[sol stringValue]],
                            [NSURLQueryItem queryItemWithName:@"api_key" value:apiKey]
                              ];

      urlComponents.queryItems = queryItems;

      NSURL *url = urlComponents.URL;
      NSLog(@"URL: %@", url);

      NSURLSessionDataTask *task = [[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {

          if (error) {
              NSLog(@"Error fetching marsRoverPhotos: %@", error);
              completionBlock(nil, error);
              return;
          }

          NSError *jsonError = nil;
          NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
          if (jsonError) {
              NSLog(@"JSON Error: %@", jsonError);
              completionBlock(nil, jsonError);
              return;
          }

          NSLog(@"JSON: %@", json);

          NSArray *photoArray = json[@"photos"];
                   NSMutableArray *photoReferences = [[NSMutableArray alloc] init];

                   for (NSDictionary *photo in photoArray) {
                       CCCMarsPhotoReference *photoReference = [[CCCMarsPhotoReference alloc] init];
                   }

          completionBlock(rover, nil);
      }];
      [task resume];
}

@end
