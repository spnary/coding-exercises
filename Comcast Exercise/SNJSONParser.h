//
//  SNJSONParser.h
//  Comcast Exercise
//
//  Created by Stephen Nary on 11/11/15.
//  Copyright © 2015 Stephen Nary. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SNJSONParserDelegate <NSObject>

// method called after json data is received
-(void)didReceiveVideoGalleries:(NSArray *)galleriesArray;

@end

@interface SNJSONParser : NSObject

@property (weak, nonatomic) id <SNJSONParserDelegate> delegate;

// test method to output the test data in a more human-friendly format
- (void)beautifyTestData;

// retrieve json data from the given url
- (void)getJSONDataFromURL:(NSURL *)url;

@end
