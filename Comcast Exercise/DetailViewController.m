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


- (void)configureView {
    
    // Load detail data from the video entity
    if (self.video) {
        [self.navigationItem setTitle:self.video.entityName];
        [self.networkLabel setText:self.video.networkName];
        [self.ratingLabel setText:[self.video.videoRating uppercaseString]];
        [self.episodeNameLabel setText:self.video.episodeName];
        [self.descriptionTextView setText:self.video.videoDescription];
        
        // display the air date in the local time and date format
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
        [dateFormatter setLocale:[NSLocale currentLocale]];
        [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
        [dateFormatter setTimeStyle:NSDateFormatterShortStyle];
        
        NSString *dateString = [dateFormatter stringFromDate:self.video.videoAirDate];
    
        [self.airDateLabel setText:dateString];
        
        // load the image from the image URL
        if (self.video.imageURL) {
            
            self.imageLoadingIndicator.hidden = NO;
            [self.imageLoadingIndicator startAnimating];
            [[[NSURLSession sharedSession] dataTaskWithURL:self.video.imageURL
                                         completionHandler:^(NSData *data,
                                                             NSURLResponse *response,
                                                             NSError *error){
                                             
                                             if (error == nil) {
                                                 UIImage *videoImage = [UIImage imageWithData:data];
                                                 
                                                 // UI Updates must be called on main thread
                                                 dispatch_async(dispatch_get_main_queue(), ^{
                                                     self.videoImageView.image = videoImage;
                                                 });
                                             }
                                             // UI Updates must be called on main thread
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
