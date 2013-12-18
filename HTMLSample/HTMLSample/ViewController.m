//
//  ViewController.m
//  HTMLSample
//
//  Created by Sandeep Kumar Gupta on 14/11/13.
//  Copyright (c) 2013 Sandeep Kumar Gupta. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
   
    
    NSString *htmlFile = [[NSBundle mainBundle] pathForResource:@"LocalPage" ofType:@"html" inDirectory:@"/"];
    NSString *htmlString = [NSString stringWithContentsOfFile:htmlFile encoding:NSUTF8StringEncoding error:nil];
   
    
//    NSString *script = @"<script src=\"first.js\"></script>";
//    htmlString = [htmlString stringByAppendingString:script];
    self.webView.delegate = self;
    
    //[_webView loadHTMLString:htmlString baseURL:nil];
    //NSString *js = [_webView stringByEvaluatingJavaScriptFromString:@"<script src=\"first.js\"></script>"];
//    NSURL *jsURL = [NSURL URLWithString:js];
   
    [_webView loadHTMLString:htmlString baseURL:nil];
    
    NSString *path = [[NSBundle mainBundle] bundlePath];
    NSString *str = [NSString stringWithFormat:@"%@",path];
    [self.webView stringByEvaluatingJavaScriptFromString:str];
    
   // NSString *jsFile = [[NSBundle mainBundle] pathForResource:@"first" ofType:@"js" inDirectory:@"/"];
//    NSString* html = [NSString stringWithFormat:@"<script src='%@'>", jsFile];
   
   }

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)webView:(UIWebView*)webView shouldStartLoadWithRequest:(NSURLRequest*)request navigationType:(UIWebViewNavigationType)navigationType

{
    NSURL *URL = [request URL];
    if ([[URL scheme] isEqualToString:@"callmycode"])
    {
        NSString *urlString = [[request URL] absoluteString];
        NSArray *urlParts = [urlString componentsSeparatedByString:@":"];
        //check to see if we just got the scheme
        if ([urlParts count] > 1) {
            NSArray *parameters = [[urlParts objectAtIndex:1] componentsSeparatedByString:@"&"];
            NSString *methodName = [parameters objectAtIndex:0];
            NSString *variableName = [parameters objectAtIndex:1];
            
            NSString *message = [NSString stringWithFormat:@"Obj-c from js with methodname=%@ and variablename=%@", methodName, variableName];
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Great" message:message delegate: self cancelButtonTitle: nil otherButtonTitles: @"OK",nil, nil];
            [alert show];
                     

           // NSString *result = [webView stringByEvaluatingJavaScriptFromString:@""];
//
           
        }
        
       
    }
    return YES;
}

@end
