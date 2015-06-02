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
    HNPItemTypeUnknown = 0,
    HNPItemTypeJob = 1,
    HNPItemTypeStory = 2,
    HNPItemTypeComment = 3,
    HNPItemTypePoll = 4,
    HNPItemTypePollOpt = 5
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
@property (nonatomic, copy) NSString<Optional> *by;

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

@end
