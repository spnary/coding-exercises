//
//  DetailViewController.h
//  Comcast Exercise
//
//  Created by Stephen Nary on 11/11/15.
//  Copyright © 2015 Stephen Nary. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SNVideoEntity;

@interface DetailViewController : UIViewController


@property (weak, nonatomic) SNVideoEntity *video; // reference to the SNVideoEntity object used to populate the detail view


@end

