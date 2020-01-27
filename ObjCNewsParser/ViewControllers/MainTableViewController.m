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

@interface MainTableViewController ()
@property(nonatomic,strong)NSArray * newsFeed;
@property(nonatomic,strong)NewsFetcher * newsFetcher;
@property(nonatomic,strong)UIRefreshControl * refreshControl;

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
    
    self.newsFetcher = [[NewsFetcher alloc]init];
    
    //Call the makeRequest to request the data
    [self makeDataRequests];
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
#warning Incomplete implementation, return the number of sections
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return 0;
}

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
