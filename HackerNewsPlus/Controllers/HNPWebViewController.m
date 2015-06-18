//
//  HNPWebViewController.m
//  HackerNewsPlus
//
//  Created by Aseem Kohli on 6/17/15.
//  Copyright (c) 2015 Aseem Kohli. All rights reserved.
//

#import "HNPWebViewController.h"

@interface HNPWebViewController ()

@property UIActivityIndicatorView *spinner;

@end

@implementation HNPWebViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.webView.delegate = self;
    self.webView.scalesPageToFit = YES;
    
    self.spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    self.spinner.color = [UIColor blueColor];
    [self.spinner setCenter:self.view.center];
    [self.view addSubview:self.spinner];
}

- (void)viewWillAppear:(BOOL)animated
{
    [self.spinner startAnimating];
    [self loadUrl];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadUrl
{
    NSLog(@"Loading URL: %@", [self.url absoluteString]);
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:self.url];
    [self.webView loadRequest:urlRequest];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [self.spinner stopAnimating];
    CGSize contentSize = self.webView.scrollView.contentSize;
    CGSize viewSize = self.view.bounds.size;
    
    float rw = viewSize.width / contentSize.width;
    
    self.webView.scrollView.minimumZoomScale = rw;
    self.webView.scrollView.maximumZoomScale = rw;
    self.webView.scrollView.zoomScale = rw; 
}

@end
