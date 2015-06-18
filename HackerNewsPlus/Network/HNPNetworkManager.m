//
//  HNPNetworkManager.m
//  HackerNewsPlus
//
//  Created by Aseem Kohli on 5/23/15.
//  Copyright (c) 2015 Aseem Kohli. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>
#import "HNPItem.h"
#import "HNPNetworkManager.h"

////////////////////////////////////////////////////////////////////////////////
#pragma mark - Class Extension

@interface HNPNetworkManager ()

@property (strong, nonatomic) NSArray *topStoryIds;
@property (strong, nonatomic) NSEnumerator *storyIdEnum;
@property (strong, nonatomic) NSMutableArray *topStories;

@end

////////////////////////////////////////////////////////////////////////////////
#pragma mark - Class Implementation

@implementation HNPNetworkManager

////////////////////////////////////////////////////////////////////////////////
#pragma mark - Setup & Teardown

+ (instancetype)sharedManager
{
    static HNPNetworkManager *sharedManager = nil;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        sharedManager = [[self alloc] init];
    });
    
    return sharedManager;
}

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        self.topStories = [[NSMutableArray alloc] init];
    }
    
    return self;
}


////////////////////////////////////////////////////////////////////////////////
#pragma mark - Public Methods

- (void)updateTopStoriesWithCompletion:(HNPNetworkCompletionBlock)completionBlock
{
    [self.topStories removeAllObjects];
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
         [self processStoryIdsWithCompletion:completionBlock];
     }
                                     failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         // Create error object
         completionBlock(nil,nil);
     }];
    
    [operation start];
}


////////////////////////////////////////////////////////////////////////////////
#pragma mark - Private Methods

- (void)processStoryIdsWithCompletion:(HNPNetworkCompletionBlock)completionBlock
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
             NSError *error = nil;
             HNPItem *item = [[HNPItem alloc] initWithDictionary:responseDict error:&error];
             [self.topStories addObject:item];
             NSLog(@"Title: %@", [item title]);
             
             [self processStoryIdsWithCompletion:completionBlock];
         }
                                         failure:^(AFHTTPRequestOperation *operation, NSError *error)
         {
             NSLog(@"Failed to get story!");
             // call completionBlock with error object
         }];
        [operation start];
    }
    else
    {
        completionBlock(self.topStories, nil);
    }
}
@end
