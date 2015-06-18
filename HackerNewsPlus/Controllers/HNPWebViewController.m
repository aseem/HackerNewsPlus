//
//  HNPWebViewController.m
//  HackerNewsPlus
//
//  Created by Aseem Kohli on 6/17/15.
//  Copyright (c) 2015 Aseem Kohli. All rights reserved.
//

#import "HNPWebViewController.h"

@interface HNPWebViewController ()

@end

@implementation HNPWebViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.webView.scalesPageToFit = YES;
    self.webView.contentMode = UIViewContentModeScaleAspectFit;
}

- (void)viewWillAppear:(BOOL)animated
{
    [self loadUrl];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadUrl
{
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:self.url];
    [self.webView loadRequest:urlRequest];
}



@end
