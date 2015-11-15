//
//  SNVideoGalleryFactory.m
//  Comcast Exercise
//
//  Created by Stephen Nary on 11/12/15.
//  Copyright © 2015 Stephen Nary. All rights reserved.
//

#import "SNVideoGalleryFactory.h"
#import "SNVideoEntityFactory.h"
#import "SNVideoGallery.h"
#import "SNVideoEntity.h"
#import "SNConstants.h"
@implementation SNVideoGalleryFactory

+ (SNVideoGallery *)videoGalleryFromDictionary:(NSDictionary *)galleryDictionary {
    
    // initialize the video gallery to return
    SNVideoGallery *videoGallery = [[SNVideoGallery alloc] init];
    
    // set the video gallery name
    if ([galleryDictionary objectForKey:HeaderKey]){
        NSDictionary *headerDictionary = [galleryDictionary objectForKey:HeaderKey];
        if ([headerDictionary objectForKey:NameKey]) {
            videoGallery.name = [headerDictionary objectForKey:NameKey];
        }
    }
    
    // create and set the array of videos
    if ([galleryDictionary objectForKey:ItemsKey]){
  
        NSArray *videosArray = galleryDictionary[ItemsKey];
        NSMutableArray<SNVideoEntity*> *tempVideos = [NSMutableArray arrayWithCapacity:50];
        
        for (NSDictionary *videoDictionary in videosArray) {
            SNVideoEntity *video = [SNVideoEntityFactory videoEntityFromDictionary:videoDictionary];
            [tempVideos addObject:video];
        }
        videoGallery.videos = tempVideos;
        
    }
    return videoGallery;
}

@end
