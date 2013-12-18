//
//  ViewController.m
//  AugmentedReality
//
//  Created by Sandeep Kumar Gupta on 29/11/13.
//  Copyright (c) 2013 Sandeep Kumar Gupta. All rights reserved.
//

#import "ViewController.h"

#import <WikitudeSDK/WTArchitectView.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if ( [WTArchitectView isDeviceSupportedForARMode:WTARMode_Geo] ) { // 1
        
        if ( !_architectView ) {
            self.architectView = [[WTArchitectView alloc] initWithFrame:self.view.bounds];
            
            [self.architectView initializeWithKey:nil motionManager:nil]; // 2
            
            [self.view addSubview:self.architectView]; //3
        }
    }
    
    NSString *path = @"1_ImageRecognition_1_ImageOnTarget";
    [self loadARchitectWorldForWorldName:path];
//    NSURL *architectWorldUrl = [[NSBundle mainBundle] URLForResource:@"index" withExtension:@"html" subdirectory:@"ARchitectExamples/1_ImageRecognition_1_ImageOnTarget"];
//    [self.architectView loadArchitectWorldFromUrl:architectWorldUrl];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated
{
    
    [super viewWillAppear:animated];
    
    [self.architectView start];
}
-(void)viewWillDisappear:(BOOL)animated
{
    
    [super viewWillDisappear:animated];
    
    [self.architectView stop];
}

- (void)loadARchitectWorldForWorldName:(NSString *)worldName
{
    if (worldName) {
        
        NSString *worldDirectory = [@"ARchitectExamples" stringByAppendingPathComponent:worldName];
        
        NSURL *absoluteWorldURL = [[NSBundle mainBundle] URLForResource:@"index" withExtension:@"html" subdirectory:worldDirectory];
        if (absoluteWorldURL) {
            [self.architectView loadArchitectWorldFromUrl:absoluteWorldURL];
        }else {
            NSLog(@"Unable to find ARchitect World path in App resouce bundle: %@", worldName);
        }
        
    }else {
        NSLog(@"Undefined ARchitect world name");
    }
}

- (void)loadARchitectWorldFromURL:(NSURL *)url
{
    if (url) {
        [self.architectView loadArchitectWorldFromUrl:url];
    }
}

@end
