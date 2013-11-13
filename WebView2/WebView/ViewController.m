//
//  ViewController.m
//  WebView
//
//  Created by Sandeep Kumar Gupta on 07/11/13.
//  Copyright (c) 2013 Sandeep Kumar Gupta. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
@synthesize viewWeb;
@synthesize viewWeb1;
@synthesize viewWeb2;
@synthesize videoUrlArray;

- (id)initWithCoder:(NSCoder*)aDecoder
{
    if(self = [super initWithCoder:aDecoder])
    {
        i = 0;
        self.videoUrlArray = [[NSMutableArray alloc]initWithObjects:nil];
        [self.videoUrlArray addObject:@"http://www.youtube.com/v/V7SVgl1HnK8&feature=c4-overview&list=UU20vb-R_px4CguHzzBPhoyQ"];
        [self.videoUrlArray addObject:@"http://www.youtube.com/v/WxkKx-hSVUk"];
        [self.videoUrlArray addObject:@"http://www.youtube.com/v/yeF_b8EQcK0"];
        [self.videoUrlArray addObject:@"http://www.youtube.com/v/W1aIpTGD_z0"];
        [self.videoUrlArray addObject:@"http://www.youtube.com/v/f4Wadm2akmk"];
        [self.videoUrlArray addObject:@"http://www.youtube.com/v/BQSyqoziHvU"];
        [self.videoUrlArray addObject:@"http://www.youtube.com/v/f4Wadm2akmk"];
        [self.videoUrlArray addObject:@"http://www.youtube.com/v/NbyHNASFi6U"];
        [self.videoUrlArray addObject:@"http://www.youtube.com/v/2kWLyInyjOE"];
        [self.videoUrlArray addObject:@"http://www.youtube.com/v/n3sYq4Y9hIQ"];
        [self.videoUrlArray addObject:@"http://www.youtube.com/v/hXHoeO9o0ZE"];
        [self.videoUrlArray addObject:@"http://www.youtube.com/v/LX0Ced3G5eg"];
        [self.videoUrlArray addObject:@"http://www.youtube.com/v/bC47NhozqG4"];
        [self.videoUrlArray addObject:@"http://www.youtube.com/v/cLIQzxgFeNE"];
        [self.videoUrlArray addObject:@"http://www.youtube.com/v/s0JJlIX5YdM"];
        [self.videoUrlArray addObject:@"http://www.youtube.com/v/n3sYq4Y9hIQ"];

       
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
//    
//      NSString *fullURL = @"http://www.youtube.com/watch?v=yeF_b8EQcK0";
//    NSURL *url = [NSURL URLWithString:fullURL];
//    NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
//    [_viewWeb loadRequest:requestObj];
    
     viewWeb.scrollView.delegate = self;
    [viewWeb.scrollView setShowsVerticalScrollIndicator:NO];
    [viewWeb.scrollView setShowsHorizontalScrollIndicator:NO];
     viewWeb.scrollView.bounces = NO;
     viewWeb.scrollView.alwaysBounceHorizontal = NO;
     viewWeb.scrollView.scrollEnabled = NO;
     viewWeb1.scrollView.delegate = self;
    [viewWeb1.scrollView setShowsVerticalScrollIndicator:NO];
    [viewWeb1.scrollView setShowsHorizontalScrollIndicator:NO];
     viewWeb1.scrollView.bounces = NO;
     viewWeb1.scrollView.alwaysBounceHorizontal = NO;
     viewWeb1.scrollView.scrollEnabled = NO;
     viewWeb2.scrollView.delegate = self;
    [viewWeb2.scrollView setShowsVerticalScrollIndicator:NO];
    [viewWeb2.scrollView setShowsHorizontalScrollIndicator:NO];
     viewWeb2.scrollView.bounces = NO;
     viewWeb2.scrollView.alwaysBounceHorizontal = NO;
     viewWeb2.scrollView.scrollEnabled = NO;
    
  
	// Do any additional setup after loading the view, typically from a nib.
    
    UISwipeGestureRecognizer *recognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(didSwipe:)];
    [recognizer setDirection:(UISwipeGestureRecognizerDirectionRight)];
    [self.view addGestureRecognizer:recognizer];
  
    
    recognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(didSwipe:)];
    [recognizer setDirection:(UISwipeGestureRecognizerDirectionLeft)];
    [self.view addGestureRecognizer:recognizer];
    
   

    [self displayVideo:[videoUrlArray objectAtIndex:i]];
    [self displayVideo1:[videoUrlArray objectAtIndex:i+1]];
    [self displayVideo2:[videoUrlArray objectAtIndex:i+2]];

}

-(void)didSwipe:(UISwipeGestureRecognizer *)gesture
{
    
    if (gesture.direction == UISwipeGestureRecognizerDirectionRight)
    {
       
        j=[videoUrlArray count];
        i = i+3;
        if (i > j-1)
            {
                i = j-1;
            }
        else
            {
        
                k = j-i;
                if(k >=3)
            
                    {
            
                        [self displayVideo:[videoUrlArray objectAtIndex:i]];
                        [self displayVideo1:[videoUrlArray objectAtIndex:i+1]];
                        [self displayVideo2:[videoUrlArray objectAtIndex:i+2]];
            
                    }
                else if (k == 2)
                    {
                        [self displayVideo:[videoUrlArray objectAtIndex:i]];
                        [self displayVideo1:[videoUrlArray objectAtIndex:i+1]];
            
                    }
                else if (k == 1)
                    {
                        [self displayVideo2:[videoUrlArray objectAtIndex:i]];
          
                    }
            }

    }
    else
    {
        i = i-3;
        if (i < 0)
            {
                i = 0;
            }
        else
            {
           
                [self displayVideo:[videoUrlArray objectAtIndex:i]];
                [self displayVideo1:[videoUrlArray objectAtIndex:i+1]];
                [self displayVideo2:[videoUrlArray objectAtIndex:i+2]];
            
            }
        
    }
       
     
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) displayVideo :(NSString *)videoUrl
{

   // viewWeb = [[UIWebView alloc] initWithFrame:CGRectMake(160,0,160,274)];
    
    //UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectMake(0,0,screenSize.width,screenSize.height)];
//    webView = [[UIWebView alloc] initWithFrame:CGRectMake(0,0,screenSize.width,screenSize.height)];
//    webView.autoresizesSubviews = YES;
//    webView.autoresizingMask=(UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth);
    
    //NSString *videoUrl = @"http://www.youtube.com/v/oHg5SJYRHA0";
    NSString *htmlString = [NSString stringWithFormat:@"<html><head><meta name = \"viewport\" content = \"initial-scale = 1.0, user-scalable = no, width = 212\"/></head><body style=\"background:#F00;margin-top:0px;margin-left:0px\"><div><object width=\"160\" height=\"274\"><param name=\"movie\" value=\"%@\"></param><param name=\"wmode\" value=\"transparent\"></param><embed src=\"%@\" type=\"application/x-shockwave-flash\" wmode=\"transparent\" width=\"160\" height=\"274\"></embed></object></div></body></html>",videoUrl,videoUrl]    ;
    
    [viewWeb loadHTMLString:htmlString baseURL:[NSURL URLWithString:@"http://www.youtube.com"]];
    
    [self.view addSubview:viewWeb];
    
    
}
- (void) displayVideo1:(NSString *)videoUrl
{
//    CGRect rect = [[UIScreen mainScreen] bounds];
//    CGSize screenSize = rect.size;
//    
//        viewWeb = [[UIWebView alloc] initWithFrame:CGRectMake(0,0,160,274)];
//    webView.autoresizesSubviews = YES;
//    webView.autoresizingMask=(UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth);
    
  //  NSString *videoUrl = @"http://www.youtube.com/v/BQSyqoziHvU";
    NSString *htmlString = [NSString stringWithFormat:@"<html><head><meta name = \"viewport\" content = \"initial-scale = 1.0, user-scalable = no, width = 212\"/></head><body style=\"background:#F00;margin-top:0px;margin-left:0px\"><div><object width=\"160\" height=\"274\"><param name=\"movie\" value=\"%@\"></param><param name=\"wmode\" value=\"transparent\"></param><embed src=\"%@\" type=\"application/x-shockwave-flash\" wmode=\"transparent\" width=\"160\" height=\"274\"></embed></object></div></body></html>",videoUrl,videoUrl]    ;
    
    [viewWeb1 loadHTMLString:htmlString baseURL:[NSURL URLWithString:@"http://www.youtube.com"]];
    
    [self.view addSubview:viewWeb1];
    
    
}

- (void) displayVideo2:(NSString *)videoUrl
{
    //    CGRect rect = [[UIScreen mainScreen] bounds];
    //    CGSize screenSize = rect.size;
    //
    //viewWeb = [[UIWebView alloc] initWithFrame:CGRectMake(0,274,320,274)];
    //    webView.autoresizesSubviews = YES;
    //    webView.autoresizingMask=(UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth);
    
  //  NSString *videoUrl = @"http://www.youtube.com/v/f4Wadm2akmk";
    NSString *htmlString = [NSString stringWithFormat:@"<html><head><meta name = \"viewport\" content = \"initial-scale = 1.0, user-scalable = no, width = 212\"/></head><body style=\"background:#F00;margin-top:0px;margin-left:0px\"><div><object width=\"320\" height=\"274\"><param name=\"movie\" value=\"%@\"></param><param name=\"wmode\" value=\"transparent\"></param><embed src=\"%@\" type=\"application/x-shockwave-flash\" wmode=\"transparent\" width=\"320\" height=\"274\"></embed></object></div></body></html>",videoUrl,videoUrl]    ;
    
    [viewWeb2 loadHTMLString:htmlString baseURL:[NSURL URLWithString:@"http://www.youtube.com"]];
    
    [self.view addSubview:viewWeb2];
    
    
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView.contentOffset.y > 0  ||  scrollView.contentOffset.y < 0 )
        scrollView.contentOffset = CGPointMake(scrollView.contentOffset.x, 0);
    // do whatever you need to with scrollDirection here.
}

@end
