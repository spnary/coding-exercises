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
  //  [self getTestData];
    NSLog(@"preparing to get data");
    [[[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:^(NSData *data,
                                                                          NSURLResponse *response,
                                                                          NSError *error){
        NSLog(@"received data");
        NSError *jsonReadError;
        NSDictionary * jsonDict = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonReadError];
        
        if (jsonReadError == nil) {
            NSLog(@"read successful");
            [self extractVideoGalleriesFromDictionary:jsonDict];
           // [self.delegate didReceiveJSONDictionary:jsonDict];
        }
        
        
    }] resume];
}

- (void)extractVideoGalleriesFromDictionary:(NSDictionary *)jsonDictionary {
    if (jsonDictionary[VideoGalleriesKey]){
        NSArray * videoGalleries = jsonDictionary[VideoGalleriesKey];
        NSLog(@"passing video galleries back to delegate");
        [self.delegate didReceiveVideoGalleries:videoGalleries];
    }
}

-(void)getTestData {
    NSLog(@"getting test data");
    NSData *jsonData = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"ComcastTestData" ofType:@"json"] ];
    NSError *readErr;
    NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:&readErr];
    if (readErr == nil) {
        NSLog(@"no errors reading test data");
        [self extractVideoGalleriesFromDictionary:jsonDict];
    }
}

@end
