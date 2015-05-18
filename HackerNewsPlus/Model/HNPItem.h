//
//  HNPItem.h
//  HackerNewsPlus
//
//  Created by Aseem Kohli on 5/17/15.
//  Copyright (c) 2015 Aseem Kohli. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <JSONModel/JSONModel.h>

////////////////////////////////////////////////////////////////////////////////
#pragma mark - HPNItemType Enum

typedef enum HNPItemType
{
    HNPItemTypeJob = 0,
    HNPItemTypeStory = 1,
    HNPItemTypeComment = 2,
    HNPItemTypePoll = 3,
    HNPItemTypePollOpt = 4
} HNPItemType;

////////////////////////////////////////////////////////////////////////////////
#pragma mark - Class Interface

@interface HNPItem : JSONModel

////////////////////////////////////////////////////////////////////////////////
#pragma mark - Public Properties

/**
 *  The item's unique id
 */
@property (nonatomic, copy) NSString *id;

/**
 *  YES if the item is deleted
 */
@property (nonatomic) BOOL deleted;

/**
 *  The type of item
 */
@property (nonatomic) HNPItemType type;

/**
 *  The username of the item's author
 */
@property (nonatomic, copy) NSString *by;

/**
 *  Creation date of the item
 */
@property (nonatomic, copy) NSDate *time;

/**
 *  The comment, sory or poll text.  HTML.
 */
@property (nonatomic, copy) NSString *text;

/**
 *  YES if the item is dead
 */
@property (nonatomic) BOOL dead;

/**
 *  The item's parent.  For comments, either another comment or the
 *  relevant story.  For pollopts, the relevant poll.
 */
@property (nonatomic, copy) NSString *parent;

/**
 *  The ids of the item's comments, in ranked display order
 */
@property (nonatomic, copy) NSArray *kids;

/**
 *  The URL of the story.
 */
@property (nonatomic, copy) NSURL *url;

/**
 *  The story's score, or the votes for a pollopt
 */
@property (nonatomic, copy) NSNumber *score;

/**
 *  The title of the story, poll or job
 */
@property (nonatomic, copy) NSString *title;

/**
 *  A list of related pollopts, in display order
 */
@property (nonatomic, copy) NSArray *parts;

/**
 *  In the case of stories or polls, the total comment count
 */
@property (nonatomic, copy) NSNumber *descendants;


////////////////////////////////////////////////////////////////////////////////
#pragma mark - Public Methods

/**
 *  The compiler will return an error if init is called
 *
 *  @return error
 */
- (id) init __attribute__((unavailable("Must use initWithData: instead.")));


- (instancetype) initWithData:(NSData *)data;

@end
