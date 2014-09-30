//
//  AuthViewController.m
//  InstagramCollage
//
//  Created by Anton on 8/15/14.
//  Copyright (c) 2014 áSoft. All rights reserved.
//


#import "AuthViewController.h"
#import "AccessToken.h"
#import "DataManager.h"

@interface AuthViewController ()

@property (strong, nonatomic) UIWebView *webView;


@end

@implementation AuthViewController




- (void)viewDidLoad
{
    [super viewDidLoad];
    
    CGRect r = self.view.bounds;
    r.origin = CGPointZero;
    
    UIWebView *webView = [[UIWebView alloc] initWithFrame:r];
    
    webView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    
    [self.view addSubview:webView];
    
    self.webView = webView;
    
    UIBarButtonItem *item  = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel
                                                                           target:self
                                                                           action:@selector(actionCancel:)];

    [self.navigationItem setRightBarButtonItem:item];
    self.navigationItem.title = @"Instagram Auth";
    
    NSString *urlString = [NSString stringWithFormat:@"https://instagram.com/oauth/authorize/?"
                           "client_id=c0678b29179a4c9e8f7854211c911d83&"
                           "client_secret=2d4c5d64a6ff4586b2d245c6c820ff87&"
                           "grant_type=autorisation_code&"
                           "redirect_uri=http://localhost&"
                           "scope=likes+basic&"
                           "response_type=token"
                           ];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:urlString]];
    
    self.webView.delegate = self;
    [webView loadRequest:request];

  
    
}


- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    
    if ([[[request URL] description] rangeOfString:@"#access_token="]. location != NSNotFound) {
        
        NSString *query = [[request URL] description];
        
        NSArray *array = [query componentsSeparatedByString:@"#"];
        if (array.count > 1) {
            query = [array lastObject];
        }
        NSArray *pairs = [query componentsSeparatedByString:@"&"];
        
        for (NSString *pair in pairs) {
            NSArray *newPair = [pair componentsSeparatedByString:@"="];
            if (newPair.count == 2) {
                NSString *key = [newPair firstObject];
                if ([key isEqualToString:@"access_token"]) {
                   [[DataManager sharedManager] setAccessToken:newPair.lastObject];;
                }
            }
        }
        
        self.webView.delegate = nil;
      
        [self dismissViewControllerAnimated:YES completion:Nil];
        
        return NO;
        
    }

    return YES;
   
}

- (void)dealloc {
    
    self.webView.delegate = nil;
}



- (void)actionCancel:(UIBarButtonItem *)item {

    [self dismissViewControllerAnimated:YES completion:nil];
    
}



@end
