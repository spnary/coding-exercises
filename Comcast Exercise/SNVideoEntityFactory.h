//
//  SNVideoEntityFactory.h
//  Comcast Exercise
//
//  Created by Stephen Nary on 11/11/15.
//  Copyright © 2015 Stephen Nary. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SNVideoEntity;

@interface SNVideoEntityFactory : NSObject

// Method to build an instance of SNVideoEntity from a dictionary 
+ (SNVideoEntity *)videoEntityFromDictionary:(NSDictionary *)videoDictionary;

@end
