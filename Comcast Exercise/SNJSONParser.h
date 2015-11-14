//
//  SNJSONParser.h
//  Comcast Exercise
//
//  Created by Stephen Nary on 11/11/15.
//  Copyright © 2015 Stephen Nary. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SNJSONParserDelegate <NSObject>

-(void)didReceiveVideoGalleries:(NSArray *)galleriesArray;

@end

@interface SNJSONParser : NSObject

@property (weak, nonatomic) id <SNJSONParserDelegate> delegate;


- (void)beautifyTestData;

- (void)getJSONDataFromURL:(NSURL *)url;

@end
