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
@property (weak, nonatomic) IBOutlet UIImageView *videoImageView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *imageLoadingIndicator;

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
    
        [self.airDateLabel setText:dateString];
        if (self.video.imageURL) {
            //TODO - animate loading indicator
            self.imageLoadingIndicator.hidden = NO;
            [self.imageLoadingIndicator startAnimating];
            [[[NSURLSession sharedSession] dataTaskWithURL:self.video.imageURL
                                         completionHandler:^(NSData *data,
                                                             NSURLResponse *response,
                                                             NSError *error){
                                             if (error == nil) {
                                                 UIImage *videoImage = [UIImage imageWithData:data];
                                                 
                                                 dispatch_async(dispatch_get_main_queue(), ^{
                                                     self.videoImageView.image = videoImage;
                                                 });
                                             } else {
                                                 
                                             }
                                             dispatch_async(dispatch_get_main_queue(), ^{
                                                 [self.imageLoadingIndicator stopAnimating];
                                                 self.imageLoadingIndicator.hidden = YES;
                                             });
                                             
                                             
                }] resume];
            
        }
        
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self configureView];
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self configureView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
