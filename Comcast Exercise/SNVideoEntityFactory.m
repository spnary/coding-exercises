//
//  SNVideoEntityFactory.m
//  Comcast Exercise
//
//  Created by Stephen Nary on 11/11/15.
//  Copyright © 2015 Stephen Nary. All rights reserved.
//

#import "SNVideoEntityFactory.h"
#import "SNVideoEntity.h"
#import "SNConstants.h"

@implementation SNVideoEntityFactory

+ (SNVideoEntity *)videoEntityFromDictionary:(NSDictionary *)videoDictionary {
    
    // create an instance of SNVideoEntityFactory to use to build the air date
    SNVideoEntityFactory *factory = [[SNVideoEntityFactory alloc] init];
    
    // initialize the video entity to be returned
    SNVideoEntity *videoEntity = [[SNVideoEntity alloc] init];
    
    // set the entity type
    if ([videoDictionary objectForKey:EntityTypeKey]){
        videoEntity.entityType = [videoDictionary objectForKey:EntityTypeKey];
    }
    
    // set the entity name
    if ([videoDictionary objectForKey:EntityNameKey]){
        videoEntity.entityName = [videoDictionary objectForKey:EntityNameKey];
    }
    
    // set the network name
    if ([videoDictionary objectForKey:NetworkNameKey]) {
        videoEntity.networkName = videoDictionary[NetworkNameKey];
    }
    
    // set the video rating
    if ([videoDictionary objectForKey:VideoRatingKey]) {
        videoEntity.videoRating = videoDictionary[VideoRatingKey];
    }
    
    // set the episode name
    if ([videoDictionary objectForKey:EpisodeNameKey]){
        videoEntity.episodeName = videoDictionary[EpisodeNameKey];
    }
    
    // set the video description
    if ([videoDictionary objectForKey:VideoDescriptionKey]){
        videoEntity.videoDescription = videoDictionary[VideoDescriptionKey];
    }
    
    // set the video air date.
    if ([videoDictionary objectForKey:VideoAirDateKey]){
        videoEntity.videoAirDate = [factory airDateFromString:videoDictionary[VideoAirDateKey]];
    }
    
    // set the image url and image alt
    if ([videoDictionary objectForKey:ImageKey]) {
        NSDictionary *imageDictionary = videoDictionary[ImageKey];
        if ([imageDictionary objectForKey:ImageAltKey]) {
            videoEntity.imageAlt = imageDictionary[ImageAltKey];
        }
        if ([imageDictionary objectForKey:ImageSrcKey]) {
            videoEntity.imageURL = [NSURL URLWithString:imageDictionary[ImageSrcKey]];
        
        }
    }
    return videoEntity;
}

-(NSDate *)airDateFromString:(NSString*)dateString {
    /*
     Sets the image date given a string of the form:
     @"Mon, 21 Sep 2015 00:00:00 GMT"
     */
    
    // separate the date string into components delimited by a space
    NSArray<NSString *> *dateComponentArray = [dateString componentsSeparatedByString:@" "];
    
    // separate the time into components using ":" as a delimiter
    NSArray<NSString *> *timeComponentArray = [dateComponentArray[4] componentsSeparatedByString:@":"];
    
    // create a number formatter to convert strings to numbers
    NSNumberFormatter *numFormatter = [[NSNumberFormatter alloc]init];
    [numFormatter setFormatterBehavior:NSNumberFormatterBehaviorDefault];
    
    // convert the day, month, and year strings into integers for use with NSDateComponents
    NSInteger dayInteger = [[numFormatter numberFromString:dateComponentArray[1]] integerValue];
    NSInteger monthInteger = [self monthIntegerFromString:dateComponentArray[2]];
    NSInteger yearInteger = [[numFormatter numberFromString:dateComponentArray[3]] integerValue];
    
    // convert the hour, minute, and second strings into integers for use with NSDateComponents
    NSInteger hourInteger = [[numFormatter numberFromString:timeComponentArray[0]] integerValue];
    NSInteger minuteInteger = [[numFormatter numberFromString:timeComponentArray[1]]integerValue];
    NSInteger secondInteger = [[numFormatter numberFromString:timeComponentArray[2]]integerValue];
    
    // create the time zone for NSDateComponents
    NSString *timeZoneString = [dateComponentArray lastObject];
    NSTimeZone *dateTimeZone = [NSTimeZone timeZoneWithAbbreviation:timeZoneString];
    
    // create an instance of NSDateComponents using the data from the date string
    NSDateComponents *dateComps = [[NSDateComponents alloc]init];
    dateComps.day = dayInteger;
    dateComps.month = monthInteger;
    dateComps.year = yearInteger;
    dateComps.hour = hourInteger;
    dateComps.minute = minuteInteger;
    dateComps.second = secondInteger;
    dateComps.timeZone = dateTimeZone;
    
    // create a calendar and use it to convert the date components to a proper NSDate object
    NSCalendar *gregorianCal = [NSCalendar calendarWithIdentifier:NSCalendarIdentifierGregorian];
    NSDate *airDate = [gregorianCal dateFromComponents:dateComps];
   
    
    return airDate;
}

-(NSInteger)monthIntegerFromString:(NSString *)monthString {
    
    // create a calendar to get the month as a string
    NSCalendar *gregorianCal = [NSCalendar calendarWithIdentifier:NSCalendarIdentifierGregorian];
    [gregorianCal setLocale:[NSLocale localeWithLocaleIdentifier:@"en-US"]];
    NSArray<NSString *> *monthSymbols = gregorianCal.shortStandaloneMonthSymbols;
    NSInteger monthInteger = 0;
  
  
    if ([monthSymbols containsObject:monthString]) {
        // month symbols index starts at 0, so add one to the index to get the true month number
        monthInteger = [monthSymbols indexOfObject:monthString] + 1;
    }
  
    return monthInteger;
    
}


@end
