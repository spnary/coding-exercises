//
//  MasterViewController.h
//  Comcast Exercise
//
//  Created by Stephen Nary on 11/11/15.
//  Copyright © 2015 Stephen Nary. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SNJSONParser.h"

@class DetailViewController;

@interface MasterViewController : UITableViewController <SNJSONParserDelegate>

@property (strong, nonatomic) DetailViewController *detailViewController;


@end

