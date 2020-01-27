//
//  MainTableViewController.m
//  ObjCNewsParser
//
//  Created by suraj poudel on 28/1/20.
//  Copyright © 2020 suraj poudel. All rights reserved.
//

#import "MainTableViewController.h"
#import "NewsFetcher.h"
#import "Constants.h"
#import "NewsTableViewCell.h"
#import "HudLoading.h"

@interface MainTableViewController ()
@property(nonatomic,strong)NSArray * newsFeed;
@property(nonatomic,strong)NewsFetcher * newsFetcher;
@property(nonatomic,strong)UIRefreshControl * refreshControl;
@property(nonatomic,strong)NSCache * cache;

@end

@implementation MainTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //Set up the TableView
    self.newsTable = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
    self.newsTable.estimatedRowHeight = UITableViewAutomaticDimension;
    self.newsTable.rowHeight = UITableViewAutomaticDimension;
    _newsTable.delegate = self;
    _newsTable.dataSource = self;
    
    [self.view addSubview:_newsTable];
    
    //Refresh Button
       UIBarButtonItem * button = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(refreshTheData)];
       self.navigationItem.leftBarButtonItem = button;
    //Add the refresh Control
       self.refreshControl = [[UIRefreshControl alloc]init];
       [self.refreshControl addTarget:self action:@selector(refreshTheData) forControlEvents:UIControlEventValueChanged];
       [self.newsTable addSubview:self.refreshControl];
    self.newsFetcher = [[NewsFetcher alloc]init];
    self.cache = [[NSCache alloc]init];
    
    //Call the makeRequest to request the data
    [self makeDataRequests];
}

-(void)refreshTheData{
    //Initialize the hudloading view
    
    HudLoading * hudLoading
    = [HudLoading hudLoadingInView:[self.view.window.subviews objectAtIndex:0]];
    //Make dataRequest
    [self makeDataRequests];
    [self.refreshControl endRefreshing];
    // update tableview
    [self.newsTable performSelector:@selector(reloadData) withObject:nil afterDelay:1.0];
    //Remove hudloading from superView
    [hudLoading
     performSelector:@selector(removeView)
     withObject:nil
     afterDelay:1.0];
}


-(void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    self.newsTable.frame = self.view.bounds;
}

-(void)makeDataRequests{
    __weak MainTableViewController *weakSelf = self;
    [self.newsFetcher searchNewsItemForURLString:kNewsFeedURL withCompletionBlock:^(NSString *newsTitle, NSArray *newsArray, NSError *error) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            if(error){
                
                UIAlertController *alertController = [UIAlertController  alertControllerWithTitle:@"Error Alert"  message:error.localizedDescription  preferredStyle:UIAlertControllerStyleAlert];
                [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                    [weakSelf dismissViewControllerAnimated:YES completion:nil];
                }]];
                    [weakSelf presentViewController:alertController animated:YES completion:nil];
                
                
            }else{
                //Parse the jsonObject and create an array and store the dictionary
                weakSelf.title = newsTitle;
                weakSelf.newsFeed = newsArray;
                dispatch_async(dispatch_get_main_queue(), ^{
                    [weakSelf.newsTable reloadData];
                });
            }
        });
    }];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.newsFeed count];
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString * CellIdentifier = @"NewsCell";
    NewsTableViewCell * cell = nil;
    cell = (NewsTableViewCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[NewsTableViewCell alloc]initWithReuseIdentifier:CellIdentifier];
    }
    
    News * news = _newsFeed[indexPath.row];
    [cell setNews:news andCache:self.cache];
    
    return cell;

}


@end
