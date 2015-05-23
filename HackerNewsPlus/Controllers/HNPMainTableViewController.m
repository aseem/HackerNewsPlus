//
//  HNPMainTableViewController.m
//  HackerNewsPlus
//
//  Created by Aseem Kohli on 5/16/15.
//  Copyright (c) 2015 Aseem Kohli. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>
#import "HNPMainTableViewController.h"
#import "HNPStoryTableViewCell.h"

typedef void (^completion_t)(id result, NSError *error);

@interface HNPMainTableViewController ()

@property (strong, nonatomic) NSArray *topStoryIds;
@property (strong, nonatomic) NSEnumerator *storyIdEnum;
@property (strong, nonatomic) NSMutableArray *topStories;

@end

@implementation HNPMainTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // load the data
    if (self.topStories == nil)
        self.topStories = [[NSMutableArray alloc] init];
    UIActivityIndicatorView *spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    spinner.color = [UIColor blueColor];
    [self.view addSubview:spinner];
    [spinner startAnimating];
    
    [self updateTopStoriesWithCompletion:^(id result, NSError *error)
     {
         dispatch_async(dispatch_get_main_queue(), ^{
             [spinner stopAnimating];
             [self.tableView reloadData];
         });
        
     }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)updateTopStoriesWithCompletion:(completion_t)completionHandler
{
    NSString *hnUrlString = @"https://hacker-news.firebaseio.com/v0/topstories.json";
    NSURL *url = [NSURL URLWithString:hnUrlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];

    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    operation.responseSerializer = [AFJSONResponseSerializer serializer];
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject)
    {
        [self setTopStoryIds:[(NSArray *)responseObject subarrayWithRange:NSMakeRange(0, 30)]];
        self.storyIdEnum = [self.topStoryIds objectEnumerator];
        NSLog(@"Top Stories: %@", [self topStoryIds]);
        [self processStoryIdsWithCompletion:completionHandler];
    }
    failure:^(AFHTTPRequestOperation *operation, NSError *error)
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error Retrieving Top Stories"
                                                            message:[error localizedDescription]
                                                           delegate:nil
                                                  cancelButtonTitle:@"Ok"
                                                  otherButtonTitles:nil];
        [alertView show];
    }];
    
    [operation start];
}

- (void)processStoryIdsWithCompletion:(completion_t)completionHandler
{
    NSString *storyId = [self.storyIdEnum nextObject];
    if (storyId != nil)
    {
        NSString *urlString = [NSString stringWithFormat:@"https://hacker-news.firebaseio.com/v0/item/%@.json", storyId];
        NSURL *url = [NSURL URLWithString:urlString];
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        
        AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
        operation.responseSerializer = [AFJSONResponseSerializer serializer];
        
        [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject)
         {
             NSDictionary *responseDict = (NSDictionary *)responseObject;
             [self.topStories addObject:[responseDict objectForKey:@"title"]];
             NSLog(@"Title: %@", [responseDict objectForKey:@"title"]);
             
             [self processStoryIdsWithCompletion:completionHandler];
         }
        failure:^(AFHTTPRequestOperation *operation, NSError *error)
         {
             NSLog(@"Failed to get story!");
         }];
        [operation start];
    }
    else
    {
        completionHandler(nil);
    }
}


#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [self.topStories count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 125;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"HNPStoryCell";
    
    HNPStoryTableViewCell *storyCell = (HNPStoryTableViewCell *) [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (storyCell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"HNPStoryTableViewCell" owner:self options:nil];
        storyCell = [nib objectAtIndex:0];
    }
    
    storyCell.titleLabel.text = self.topStories[indexPath.row];
    storyCell.scoreLabel.text = @"100";
    storyCell.numCommentsLabel.text = @"200";

    return storyCell;
}


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
