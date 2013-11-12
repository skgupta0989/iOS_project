//
//  ViewController.h
//  WebView
//
//  Created by Sandeep Kumar Gupta on 07/11/13.
//  Copyright (c) 2013 Sandeep Kumar Gupta. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UIWebViewDelegate,UIGestureRecognizerDelegate,UIScrollViewDelegate>
{
    NSMutableArray *videoUrlArray;
    int i,j,k;
}
@property (strong,nonatomic)NSMutableArray *videoUrlArray;
@property (strong, nonatomic) IBOutlet UIWebView *viewWeb;
@property (weak, nonatomic) IBOutlet UIWebView *viewWeb1;
@property (weak, nonatomic) IBOutlet UIWebView *viewWeb2;
- (void) displayVideo :(NSString *)videoUrl;
- (void) displayVideo1 :(NSString *)videoUrl;
- (void) displayVideo2 :(NSString *)videoUrl;
@end
