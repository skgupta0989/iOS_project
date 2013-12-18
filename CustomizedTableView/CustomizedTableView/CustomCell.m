//
//  CustomCell.m
//  CustomizedTableView
//
//  Created by Sandeep Kumar Gupta on 25/11/13.
//  Copyright (c) 2013 Sandeep Kumar Gupta. All rights reserved.
//

#import "CustomCell.h"
#import <MobileCoreServices/MobileCoreServices.h>
#import "ViewController.h"


@implementation CustomCell
@synthesize imageView;
@synthesize selectButton;


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
        self.imagePicker = [[UIImagePickerController alloc] init];
        self.imagePicker.delegate = self;
        self.imageView = [[UIImageView alloc] init];
        
            }
    return self;
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (IBAction)cellSelectImage:(UIControl*)sender
{

    UIButton *button = (UIButton*)sender;
    NSIndexPath *myIP = [NSIndexPath indexPathForRow:sender.tag inSection:0];
    //Type cast it to CustomCell
//    CustomCell *cell = (CustomCell*)[tblView1 cellForRowAtIndexPath:myIP];
//    UIButton *btn = cell.btn;
//    NSLog(@"btn text %@, tag %d",btn.titleLabel.text,btn.tag);
//    
//    UITextField *tf = cell.textField2;
//    NSLog(@"tf text %@, tag %d",tf.text,btn.tag);
    
     [self.imageDelegate selectedCell:imageView];
       
   
    
}




@end
