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

//@property (strong, nonatomic) id detailItem;
//@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;

@property (weak, nonatomic) SNVideoEntity *video;


@end

