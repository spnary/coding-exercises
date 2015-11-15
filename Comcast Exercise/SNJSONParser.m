//
//  SNJSONParser.m
//  Comcast Exercise
//
//  Created by Stephen Nary on 11/11/15.
//  Copyright © 2015 Stephen Nary. All rights reserved.
//

#import "SNJSONParser.h"
#import "SNConstants.h"

@implementation SNJSONParser

- (void)beautifyTestData {
    // test method to convert json data to a more human friendly format
    // reads ComcastTestData and then writes it to a dictionary using NSJSONWritingPrettyPrinted option
    NSData *jsonData = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"ComcastTestData" ofType:@"json"] ];
    NSError *readErr;
    NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:&readErr];
    if (readErr == nil) {
        
        NSError *writeErr;
        NSData *prettyData = [NSJSONSerialization dataWithJSONObject:jsonDict options:NSJSONWritingPrettyPrinted error:&writeErr];
        if (writeErr == nil) {
            NSString *jsonString = [[NSString alloc] initWithData:prettyData encoding:NSUTF8StringEncoding];
            NSLog(@"%@", jsonString);
        }
    }
}

- (void)getJSONDataFromURL:(NSURL*)url {
    // uncomment the following line to test from local file when no internet connection available
    //[self getTestData];

    [[[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:^(NSData *data,
                                                                          NSURLResponse *response,
                                                                          NSError *error){
        if (error == nil) {
   
            NSError *jsonReadError;
            NSDictionary * jsonDict = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonReadError];
            
            if (jsonReadError == nil) {
     
                [self extractVideoGalleriesFromDictionary:jsonDict];
             
            }
        } else {
      
        }
        
        
    }] resume];
}

- (void)extractVideoGalleriesFromDictionary:(NSDictionary *)jsonDictionary {
    // get the video galleries from the retrieved data
    if (jsonDictionary[VideoGalleriesKey]){
        NSArray * videoGalleries = jsonDictionary[VideoGalleriesKey];
      
        [self.delegate didReceiveVideoGalleries:videoGalleries];
    }
}

-(void)getTestData {
    // test method for getting json data from a local file
    // useful for doing development work when no internet connection is available
    NSData *jsonData = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"ComcastTestData" ofType:@"json"] ];
    NSError *readErr;
    NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:&readErr];
    if (readErr == nil) {
   
        [self extractVideoGalleriesFromDictionary:jsonDict];
    }
}

@end
