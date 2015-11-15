//
//  SNVideoGallery.h
//  Comcast Exercise
//
//  Created by Stephen Nary on 11/12/15.
//  Copyright © 2015 Stephen Nary. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SNVideoEntity;

@interface SNVideoGallery : NSObject

@property (strong, nonatomic) NSArray<SNVideoEntity *> *videos; // Array of videos
@property (strong, nonatomic) NSString *name; // name of entity, usually the night the shows aired (e.g. Mon Night TV)

@end
