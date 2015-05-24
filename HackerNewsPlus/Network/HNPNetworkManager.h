//
//  HNPNetworkManager.h
//  HackerNewsPlus
//
//  Created by Aseem Kohli on 5/23/15.
//  Copyright (c) 2015 Aseem Kohli. All rights reserved.
//

#import <Foundation/Foundation.h>

////////////////////////////////////////////////////////////////////////////////
#pragma mark - Types

typedef void (^HNPNetworkCompletionBlock)(id result, NSError *error);


@interface HNPNetworkManager : NSObject

////////////////////////////////////////////////////////////////////////////////
#pragma mark - Public Singleton Methods

/**
 *  Returns the shared instance of the HNPNetworkManager
 *
 *  @return shared HNPNetworkManager object
 */
+ (instancetype)sharedManager;


////////////////////////////////////////////////////////////////////////////////
#pragma mark - Public Instance Methods

/**
 *  Async method that downloads the top stories from Hacker News.
 *
 *  @param completionBlock HNPNetworkCompletionBlock that is called when the
 *  stories are downloaded.
 */
- (void)updateTopStoriesWithCompletion:(HNPNetworkCompletionBlock)completionBlock;

@end
