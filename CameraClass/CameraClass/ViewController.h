//
//  ViewController.h
//  CameraClass
//
//  Created by Sandeep Kumar Gupta on 13/11/13.
//  Copyright (c) 2013 Sandeep Kumar Gupta. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MobileCoreServices/MobileCoreServices.h>
@interface ViewController : UIViewController<UIImagePickerControllerDelegate,UINavigationControllerDelegate>

{
    UIImageView *imageView;
    BOOL newMedia;
}
@property (nonatomic, retain) IBOutlet UIImageView *imageView;
- (IBAction)useCamera;
- (IBAction)useCameraRoll;

@end
