//
//  HNPMainTableViewController.m
//  HackerNewsPlus
//
//  Created by Aseem Kohli on 5/16/15.
//  Copyright (c) 2015 Aseem Kohli. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>
#import "HNPMainTableViewController.h"
#import "HNPNetworkManager.h"
#import "HNPStoryTableViewCell.h"

typedef void (^completion_t)(id result, NSError *error);

@interface HNPMainTableViewController ()

@property (strong, nonatomic) NSArray *topStoryIds;
@property (strong, nonatomic) NSEnumerator *storyIdEnum;
@property (strong, nonatomic) NSMutableArray *topStories;

@end

@implementation HNPMainTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // load the data
    if (self.topStories == nil)
        self.topStories = [[NSMutableArray alloc] init];
    UIActivityIndicatorView *spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    spinner.color = [UIColor blueColor];
    [self.view addSubview:spinner];
    [spinner startAnimating];
    
    [[HNPNetworkManager sharedManager] updateTopStoriesWithCompletion:^(id result, NSError *error)
     {
         self.topStories = (NSMutableArray *)result;
         dispatch_async(dispatch_get_main_queue(), ^{
             [spinner stopAnimating];
             [self.tableView reloadData];
         });
        
     }];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
