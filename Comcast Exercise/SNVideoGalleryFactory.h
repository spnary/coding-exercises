//
//  SNVideoGalleryFactory.h
//  Comcast Exercise
//
//  Created by Stephen Nary on 11/12/15.
//  Copyright © 2015 Stephen Nary. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SNVideoGallery;

@interface SNVideoGalleryFactory : NSObject

+ (SNVideoGallery *)videoGalleryFromDictionary:(NSDictionary *)galleryDictionary;

@end
