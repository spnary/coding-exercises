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
    
    SNVideoEntityFactory *factory = [[SNVideoEntityFactory alloc] init];
    SNVideoEntity *videoEntity = [[SNVideoEntity alloc] init];
    
    if ([videoDictionary objectForKey:EntityNameKey]){
        videoEntity.entityName = [videoDictionary objectForKey:EntityNameKey];
    }
    
    if ([videoDictionary objectForKey:NetworkNameKey]) {
        videoEntity.networkName = videoDictionary[NetworkNameKey];
    }
    
    if ([videoDictionary objectForKey:VideoRatingKey]) {
        videoEntity.videoRating = videoDictionary[VideoRatingKey];
    }
    
    if ([videoDictionary objectForKey:EpisodeNameKey]){
        videoEntity.episodeName = videoDictionary[EpisodeNameKey];
    }
    
    if ([videoDictionary objectForKey:VideoDescriptionKey]){
        videoEntity.videoDescription = videoDictionary[VideoDescriptionKey];
    }
    
    if ([videoDictionary objectForKey:VideoAirDateKey]){
        videoEntity.videoAirDate = [factory airDateFromString:videoDictionary[VideoAirDateKey]];
    }
    
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
    /*Mon, 21 Sep 2015 00:00:00 GMT*/
    NSArray<NSString *> *dateComponentArray = [dateString componentsSeparatedByString:@" "];
    NSArray<NSString *> *timeComponentArray = [dateComponentArray[4] componentsSeparatedByString:@":"];
    
    NSNumberFormatter *numFormatter = [[NSNumberFormatter alloc]init];
    [numFormatter setFormatterBehavior:NSNumberFormatterBehaviorDefault];
    
    NSInteger dayInteger = [[numFormatter numberFromString:dateComponentArray[1]] integerValue];
    NSInteger monthInteger = [self monthIntegerFromString:dateComponentArray[2]];
    NSInteger yearInteger = [[numFormatter numberFromString:dateComponentArray[3]] integerValue];
    
    NSInteger hourInteger = [[numFormatter numberFromString:timeComponentArray[0]] integerValue];
    NSInteger minuteInteger = [[numFormatter numberFromString:timeComponentArray[1]]integerValue];
    NSInteger secondInteger = [[numFormatter numberFromString:timeComponentArray[2]]integerValue];
    
    NSString *timeZoneString = [dateComponentArray lastObject];
    NSTimeZone *dateTimeZone = [NSTimeZone timeZoneWithAbbreviation:timeZoneString];
    
    NSDateComponents *dateComps = [[NSDateComponents alloc]init];
    dateComps.day = dayInteger;
    dateComps.month = monthInteger;
    dateComps.year = yearInteger;
    dateComps.hour = hourInteger;
    dateComps.minute = minuteInteger;
    dateComps.second = secondInteger;
    dateComps.timeZone = dateTimeZone;
    
    NSCalendar *gregorianCal = [NSCalendar calendarWithIdentifier:NSCalendarIdentifierGregorian];

    
    NSDate *airDate = [gregorianCal dateFromComponents:dateComps];
   
    
    return airDate;
}

-(NSInteger)monthIntegerFromString:(NSString *)monthString {
    NSCalendar *gregorianCal = [NSCalendar calendarWithIdentifier:NSCalendarIdentifierGregorian];
    [gregorianCal setLocale:[NSLocale localeWithLocaleIdentifier:@"en-US"]];
    NSArray<NSString *> *monthSymbols = gregorianCal.shortStandaloneMonthSymbols;
    NSInteger monthInteger = 0;
  
  
    if ([monthSymbols containsObject:monthString]) {
   
        monthInteger = [monthSymbols indexOfObject:monthString] + 1;
    }
  
    return monthInteger;
    
}


@end
