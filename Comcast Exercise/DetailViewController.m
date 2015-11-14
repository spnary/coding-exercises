//
//  DetailViewController.m
//  Comcast Exercise
//
//  Created by Stephen Nary on 11/11/15.
//  Copyright © 2015 Stephen Nary. All rights reserved.
//

#import "DetailViewController.h"
#import "SNVideoEntity.h"

@interface DetailViewController ()
@property (weak, nonatomic) IBOutlet UILabel *networkLabel;
@property (weak, nonatomic) IBOutlet UILabel *ratingLabel;
@property (weak, nonatomic) IBOutlet UILabel *episodeNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *airDateLabel;
@property (weak, nonatomic) IBOutlet UITextView *descriptionTextView;

@end

@implementation DetailViewController

#pragma mark - Managing the detail item

- (void)setDetailItem:(id)newDetailItem {
 /*   if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
            
        // Update the view.
        [self configureView];
    }*/
}

- (void)configureView {
    // Update the user interface for the detail item.
/*    if (self.detailItem) {
        self.detailDescriptionLabel.text = [self.detailItem description];
    }*/
    if (self.video) {
        [self.navigationItem setTitle:self.video.entityName];
        [self.networkLabel setText:self.video.networkName];
        [self.ratingLabel setText:[self.video.videoRating uppercaseString]];
        [self.episodeNameLabel setText:self.video.episodeName];
        [self.descriptionTextView setText:self.video.videoDescription];
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
        [dateFormatter setLocale:[NSLocale currentLocale]];
        [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
        [dateFormatter setTimeStyle:NSDateFormatterShortStyle];
        
        NSString *dateString = [dateFormatter stringFromDate:self.video.videoAirDate];
        NSLog(@"date String: %@", dateString);
        [self.airDateLabel setText:dateString];
        
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self configureView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
