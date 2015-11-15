//
//  SNVideoEntity.h
//  Comcast Exercise
//
//  Created by Stephen Nary on 11/11/15.
//  Copyright © 2015 Stephen Nary. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SNVideoEntity : NSObject

@property (strong, nonatomic) NSString *entityType;         // The video entity type (e.g. TV Show)
@property (strong, nonatomic) NSString *entityName;         // The name of the video entity (for a TV Show, the series name)
@property (strong, nonatomic) NSString *networkName;        // The name of the network (e.g. NBC, HBO, FOX, ABC, etc)
@property (strong, nonatomic) NSString *videoDescription;   // A description of the video
@property (strong, nonatomic) NSDate *videoAirDate;         // The original air date of the video
@property (strong, nonatomic) NSString *episodeName;        // The name of the episode
@property (strong, nonatomic) NSURL *imageURL;              // the URL of the image related to the video
@property (strong, nonatomic) NSString *imageAlt;           // a text string that describes the image in imageURL
@property (strong, nonatomic) NSString *videoRating;        // the rating of the video (e.g. tv-pg)

@end
