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
    //[self getTestData];

    [[[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:^(NSData *data,
                                                                          NSURLResponse *response,
                                                                          NSError *error){
        if (error == nil) {
   
            NSError *jsonReadError;
            NSDictionary * jsonDict = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonReadError];
            
            if (jsonReadError == nil) {
     
                [self extractVideoGalleriesFromDictionary:jsonDict];
               // [self.delegate didReceiveJSONDictionary:jsonDict];
            }
        } else {
      
        }
        
        
    }] resume];
}

- (void)extractVideoGalleriesFromDictionary:(NSDictionary *)jsonDictionary {
    if (jsonDictionary[VideoGalleriesKey]){
        NSArray * videoGalleries = jsonDictionary[VideoGalleriesKey];
      
        [self.delegate didReceiveVideoGalleries:videoGalleries];
    }
}

-(void)getTestData {
 
    NSData *jsonData = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"ComcastTestData" ofType:@"json"] ];
    NSError *readErr;
    NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:&readErr];
    if (readErr == nil) {
   
        [self extractVideoGalleriesFromDictionary:jsonDict];
    }
}

@end
