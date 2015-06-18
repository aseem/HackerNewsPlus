//
//  HNPWebViewController.h
//  HackerNewsPlus
//
//  Created by Aseem Kohli on 6/17/15.
//  Copyright (c) 2015 Aseem Kohli. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HNPWebViewController : UIViewController<UIWebViewDelegate>

@property (strong, nonatomic) IBOutlet UIWebView *webView;
@property (nonatomic, copy) NSURL *url;

@end
