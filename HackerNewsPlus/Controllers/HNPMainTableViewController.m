//
//  HNPMainTableViewController.m
//  HackerNewsPlus
//
//  Created by Aseem Kohli on 5/16/15.
//  Copyright (c) 2015 Aseem Kohli. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>
#import "HNPItem.h"
#import "HNPMainTableViewController.h"
#import "HNPNetworkManager.h"
#import "HNPStoryTableViewCell.h"
#import "HNPWebViewController.h"

typedef void (^completion_t)(id result, NSError *error);

@interface HNPMainTableViewController ()

@property (strong, nonatomic) NSArray *topStoryIds;
@property (strong, nonatomic) NSEnumerator *storyIdEnum;
@property (strong, nonatomic) NSMutableArray *topStories;
@property UIActivityIndicatorView *spinner;
@end

@implementation HNPMainTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // load the data
    if (self.topStories == nil)
        self.topStories = [[NSMutableArray alloc] init];
    
    UIBarButtonItem *refreshButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(refresh)];
    self.navigationItem.rightBarButtonItem = refreshButton;
    
    self.spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    self.spinner.color = [UIColor blueColor];
    [self.spinner setCenter:self.view.center];
    [self.view addSubview:self.spinner];
    [self refresh];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)refresh
{
    [self.spinner startAnimating];
    [[HNPNetworkManager sharedManager] updateTopStoriesWithCompletion:^(id result, NSError *error)
     {
         self.topStories = (NSMutableArray *)result;
         dispatch_async(dispatch_get_main_queue(), ^{
             [self.spinner stopAnimating];
             [self.tableView reloadData];
         });
         
     }];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    HNPWebViewController *webViewController = segue.destinationViewController;
    [webViewController setUrl:[self.selectedItem url]];
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
    
    storyCell.titleLabel.text = [self.topStories[indexPath.row] title];
    storyCell.scoreLabel.text = [[self.topStories[indexPath.row] score] stringValue];
    storyCell.numCommentsLabel.text = [[self.topStories[indexPath.row] descendants] stringValue];

    return storyCell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.selectedItem = [self.topStories objectAtIndex:indexPath.row];
    [self performSegueWithIdentifier:@"showWebView" sender:self];
}


@end
