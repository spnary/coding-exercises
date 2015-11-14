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
    return videoEntity;
}



@end
