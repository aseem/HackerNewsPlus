//
//  HNPStoryTableViewCell.h
//  HackerNewsPlus
//
//  Created by Aseem Kohli on 5/16/15.
//  Copyright (c) 2015 Aseem Kohli. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HNPStoryTableViewCell : UITableViewCell

@property (nonatomic, weak) IBOutlet UILabel *titleLabel;
@property (nonatomic, weak) IBOutlet UILabel *scoreLabel;
@property (nonatomic, weak) IBOutlet UILabel *numCommentsLabel;

@end
