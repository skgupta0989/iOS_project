//
//  CustomCell.h
//  CustomizedTableView
//
//  Created by Sandeep Kumar Gupta on 25/11/13.
//  Copyright (c) 2013 Sandeep Kumar Gupta. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CustomCellDelegate <NSObject>

@required
-(void)selectedCell:(UIImagePickerController*)value;
@end

@interface CustomCell : UITableViewCell<UIImagePickerControllerDelegate,UINavigationControllerDelegate,UITableViewDataSource,UITableViewDelegate>
{
    UIImageView *imageView;
    BOOL newMedia;
  
   
}
@property (nonatomic ,retain)id<CustomCellDelegate> imageDelegate;
@property (nonatomic, retain) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIButton *selectButton;
@property (nonatomic, retain) IBOutlet UIImagePickerController *imagePicker;

- (IBAction)cellSelectImage:(id)sender;


@end
