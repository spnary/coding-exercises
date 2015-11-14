//
//  MasterViewController.m
//  Comcast Exercise
//
//  Created by Stephen Nary on 11/11/15.
//  Copyright © 2015 Stephen Nary. All rights reserved.
//

#import "MasterViewController.h"
#import "DetailViewController.h"
#import "SNJSONParser.h"
#import "SNVideoGalleryFactory.h"
#import "SNVideoEntityFactory.h"
#import "SNVideoGallery.h"
#import "SNVideoEntity.h"
#import "SNConstants.h"

@interface MasterViewController ()

@property NSMutableArray *objects;
@property (strong, nonatomic) SNJSONParser *parser;
@property (strong, nonatomic) NSArray<SNVideoGallery*> *videoGalleries;
@end

@implementation MasterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    self.detailViewController = (DetailViewController *)[[self.splitViewController.viewControllers lastObject] topViewController];
    [self.navigationItem setTitle:MasterViewNavItemTitle];
    if (self.parser == nil) {
        NSLog(@"Setting up parser");
        self.parser = [[SNJSONParser alloc]init];
        self.parser.delegate = self;
     
        [self.parser getJSONDataFromURL:[NSURL URLWithString:ComcastURLString]];
    }
}

- (void)viewWillAppear:(BOOL)animated {
    self.clearsSelectionOnViewWillAppear = self.splitViewController.isCollapsed;
    [super viewWillAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Segues

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        DetailViewController *controller = (DetailViewController *)[[segue destinationViewController] topViewController];
        [controller setVideo:self.videoGalleries[indexPath.section].videos[indexPath.row]];
        controller.navigationItem.leftBarButtonItem = self.splitViewController.displayModeButtonItem;
        controller.navigationItem.leftItemsSupplementBackButton = YES;
    }
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.videoGalleries.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.videoGalleries[section].videos.count;
  
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];

    SNVideoEntity *video = self.videoGalleries[indexPath.section].videos[indexPath.row];
    cell.textLabel.text = video.entityName;
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return self.videoGalleries[section].name;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return NO;
}

#pragma mark = SNJSONParser Delegate Methods

- (void)didReceiveVideoGalleries:(NSArray *)galleriesArray {
    NSDictionary *galleryDictionary;
    NSMutableArray<SNVideoGallery*> *tempVideos = [NSMutableArray arrayWithCapacity:50];
    for (galleryDictionary in galleriesArray) {
        SNVideoGallery *gallery = [SNVideoGalleryFactory videoGalleryFromDictionary:galleryDictionary];
        [tempVideos addObject:gallery];
    }
    self.videoGalleries = tempVideos;
    
    [self.tableView reloadData];
}

@end
