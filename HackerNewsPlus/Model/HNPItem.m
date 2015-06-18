//
//  HNPItem.m
//  HackerNewsPlus
//
//  Created by Aseem Kohli on 5/17/15.
//  Copyright (c) 2015 Aseem Kohli. All rights reserved.
//

#import "HNPItem.h"

@implementation HNPItem

// overrided this method to mark specific properties
// as required and everything else optional
+ (BOOL)propertyIsOptional:(NSString *)propertyName
{
    if ([propertyName isEqualToString:@"id"]) return NO;
    if ([propertyName isEqualToString:@"time"]) return NO;
    if ([propertyName isEqualToString:@"by"]) return NO;
    if ([propertyName isEqualToString:@"type"]) return NO;
    return YES;
}

// handle enum conversion
- (void)setTypeWithNSString:(NSString *)type
{
    NSLog(@"TYPE: %@", type);
    _type = HNPItemTypeUnknown;
    if ([type isEqualToString:@"job"]) _type = HNPItemTypeJob;
    if ([type isEqualToString:@"story"]) _type = HNPItemTypeStory;
    if ([type isEqualToString:@"comment"]) _type = HNPItemTypeComment;
    if ([type isEqualToString:@"poll"]) _type = HNPItemTypePoll;
    if ([type isEqualToString:@"pollopt"]) _type = HNPItemTypePollOpt;
}

@end
