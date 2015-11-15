//
//  SNVideoEntityFactoryTests.m
//  Comcast Exercise
//
//  Created by Stephen Nary on 11/11/15.
//  Copyright © 2015 Stephen Nary. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "SNVideoEntityFactory.h"
#import "SNVideoEntity.h"

@interface SNVideoEntityFactoryTests : XCTestCase

@property (strong, nonatomic) SNVideoEntity *controlEntity;
@property (strong, nonatomic) NSDictionary *testDictionary;

@end

@implementation SNVideoEntityFactoryTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    NSDateComponents *airDateComponents = [[NSDateComponents alloc] init];
    airDateComponents.day = 21;
    airDateComponents.month = 9;
    airDateComponents.year = 2015;
    airDateComponents.hour = 0;
    airDateComponents.minute = 0;
    airDateComponents.second = 0;
    airDateComponents.timeZone = [NSTimeZone timeZoneWithAbbreviation:@"GMT"];
    self.controlEntity = [[SNVideoEntity alloc]init];
    self.controlEntity.entityType = @"TvSeries";
    self.controlEntity.entityName = @"The Voice";
    self.controlEntity.networkName = @"NBC";
    self.controlEntity.videoDescription = @"In the season premiere, Blake Shelton, Pharrell Williams, Adam Levine and Gwen Stefani begin a new search for America's best new singer as hopefuls take the stage to blind audition.";
    self.controlEntity.videoAirDate = [[NSCalendar currentCalendar]dateFromComponents:airDateComponents];//@"Mon, 21 Sep 2015 00:00:00 GMT";
    self.controlEntity.episodeName = @"The Blind Auditions Premiere";
    self.controlEntity.imageURL = [NSURL URLWithString:@"http://static-p-a.comcast.net/api/assets/cimed-20130131/transparent.png"];
    self.controlEntity.imageAlt = @"The Voice";
    self.controlEntity.videoRating = @"tv-pg";
    
    
    self.testDictionary = @{@"entityType" : @"TvSeries",
                            @"videoNetworkDisplayName" : @"NBC",
                            @"videoDescription" : @"In the season premiere, Blake Shelton, Pharrell Williams, Adam Levine and Gwen Stefani begin a new search for America's best new singer as hopefuls take the stage to blind audition.",
                            @"episodeOriginalAirDate" : @"Mon, 21 Sep 2015 00:00:00 GMT",
                            @"entityName" : @"The Voice",
                            @"videoName" : @"The Blind Auditions Premiere",
                            @"image" : @{ @"alt":@"The Voice",
                                           @"src":@"http:\/\/static-p-a.comcast.net\/api\/assets\/cimed-20130131\/transparent.png"},
                            @"videoRating" : @"tv-pg",
                            @"videoDuration" : @"5133",
                            @"episodeSeasonNumber" : @"9",
                            @"episodeNumber" : @"1"
                            };
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testVideoEntityFromDictionary {
    SNVideoEntity *testEntity = [SNVideoEntityFactory videoEntityFromDictionary:self.testDictionary];
    
    XCTAssertEqualObjects(testEntity.entityType, self.controlEntity.entityType, @"entity type must be equal") ;
    XCTAssertEqualObjects(testEntity.entityName,self.controlEntity.entityName, @"entity names must be equal");
    XCTAssertEqualObjects(testEntity.networkName, self.controlEntity.networkName, @"network names must be equal");
    XCTAssertEqualObjects(testEntity.videoDescription, self.controlEntity.videoDescription, @"video descriptions must be equal");
    XCTAssertEqualObjects(testEntity.videoAirDate ,self.controlEntity.videoAirDate, @"video air dates must be equal");
    XCTAssertEqualObjects(testEntity.episodeName, self.controlEntity.episodeName, @"episode names must be equal");
    XCTAssertEqualObjects(testEntity.imageURL, self.controlEntity.imageURL, @"image URLs must be equal");
    XCTAssertEqualObjects(testEntity.imageAlt, self.controlEntity.imageAlt, @"image alts must be equal");
    XCTAssertEqualObjects(testEntity.videoRating, self.controlEntity.videoRating, @"video ratings must be equal");

}

@end
