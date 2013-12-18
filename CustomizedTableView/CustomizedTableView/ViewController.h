//
//  ViewController.h
//  CustomizedTableView
//
//  Created by Sandeep Kumar Gupta on 22/11/13.
//  Copyright (c) 2013 Sandeep Kumar Gupta. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomCell.h"
@interface ViewController :UITableViewController<UINavigationControllerDelegate,UIImagePickerControllerDelegate,CustomCellDelegate>
{
    
    UIImageView *chosenView;
      BOOL newMedia;
    
}
@property (weak, nonatomic) IBOutlet UITableView *myTableView;
@property (nonatomic, retain) IBOutlet UIImageView *chosenView;
@property (weak, nonatomic) IBOutlet UIButton *selectButton;
@property(nonatomic,retain)CustomCell *custom;
//- (IBAction)selectImage:(UIButton *)sender;

@end
