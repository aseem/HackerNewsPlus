//
//  HNPMainTableViewController.h
//  HackerNewsPlus
//
//  Created by Aseem Kohli on 5/16/15.
//  Copyright (c) 2015 Aseem Kohli. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HNPItem;

@interface HNPMainTableViewController : UITableViewController

@property (nonatomic) HNPItem *selectedItem;

@end
