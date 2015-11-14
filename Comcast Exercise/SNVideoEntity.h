//
//  SNVideoEntity.h
//  Comcast Exercise
//
//  Created by Stephen Nary on 11/11/15.
//  Copyright © 2015 Stephen Nary. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SNVideoEntity : NSObject

@property (strong, nonatomic) NSString *entityType;
@property (strong, nonatomic) NSString *entityName;
@property (strong, nonatomic) NSString *networkName;
@property (strong, nonatomic) NSString *videoDescription;
@property (strong, nonatomic) NSDate *videoAirDate;
@property (strong, nonatomic) NSString *episodeName;
@property (strong, nonatomic) NSURL *imageURL;
@property (strong, nonatomic) NSString *videoRating;
@property NSInteger episodeSeason;
@property NSInteger episodeNumber;
@property NSTimeInterval videoDuration;

@end
