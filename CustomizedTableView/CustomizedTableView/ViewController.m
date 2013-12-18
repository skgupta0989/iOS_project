//
//  ViewController.m
//  CustomizedTableView
//
//  Created by Sandeep Kumar Gupta on 22/11/13.
//  Copyright (c) 2013 Sandeep Kumar Gupta. All rights reserved.
//

#import "ViewController.h"
#import <MobileCoreServices/MobileCoreServices.h>
#import "QuartzCore/QuartzCore.h"
#import "CustomCell.h"
@interface ViewController ()<CustomCellDelegate>
{
      CustomCell *aCell;
    UIImage *selectedImage;
}
    
@end

@implementation ViewController
@synthesize chosenView;
//@synthesize imageView;
//@synthesize selectButton;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.custom = [[CustomCell alloc] init];
   // self.custom.delegate = self;
    self.myTableView.delegate = self;
    
//    [self.tableView registerClass:[CustomCell class] forCellReuseIdentifier:CellIdentifier];
    //
//    UIButton *customButton = [UIButton buttonWithType: UIButtonTypeCustom];
//    [customButton setBackgroundColor: [UIColor greenColor]];
//    [customButton setTitleColor:[UIColor blackColor] forState:
//     UIControlStateHighlighted];
//    //sets background image for normal state
//    [customButton setBackgroundImage:[UIImage imageNamed:
//                                      @"Button_Default.png"]
//                            forState:UIControlStateNormal];
//    //sets background image for highlighted state
//    [customButton setBackgroundImage:[UIImage imageNamed:
//                                      @"Button_Highlighted.png"]
//                            forState:UIControlStateHighlighted];
//    [customButton setFrame:CGRectMake(60, 100, 200, 40)];
//    [customButton setTitle:@"Custom Button" forState:UIControlStateNormal];
//    [self.view addSubview:customButton];
//    
//    
//    selectButton.layer.borderWidth=1.0f;
//    selectButton.layer.borderColor=[[UIColor blackColor] CGColor];
    
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
    // Assign our own backgroud for the view
    self.parentViewController.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"gradientBackground.png"]];
    self.tableView.backgroundColor = [UIColor clearColor];
    
    // Add padding to the top of the table view
    UIEdgeInsets inset = UIEdgeInsetsMake(5, 0, 0, 0);
    self.tableView.contentInset = inset;
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return 30;
}
/*
- (UIImage *)cellBackgroundForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger rowCount = [self tableView:[self tableView] numberOfRowsInSection:[indexPath section]];
    NSInteger rowIndex = indexPath.row;
    UIImage *background = nil;
    UIImage *selectionBackground = nil;
    
    if (rowIndex == 0 && rowIndex == rowCount - 1)
	{
		background = [UIImage imageNamed:@"topAndBottomRow.png"];
		selectionBackground = [UIImage imageNamed:@"topAndBottomRowSelected.png"];
	}
	else if (rowIndex == 0)
	{
		background = [UIImage imageNamed:@"topRow.png"];
		selectionBackground = [UIImage imageNamed:@"topRowSelected.png"];
	}
	else if (rowIndex == rowCount - 1)
	{
		background = [UIImage imageNamed:@"bottomRow.png"];
		selectionBackground = [UIImage imageNamed:@"bottomRowSelected.png"];
	}
	else
	{
		background = [UIImage imageNamed:@"middleRow.png"];
		selectionBackground = [UIImage imageNamed:@"middleRowSelected.png"];
	}
	
	

//    if (rowIndex == 0) {
//        background = [UIImage imageNamed:@"cell_top.png"];
//    } else if (rowIndex == rowCount - 1) {
//        background = [UIImage imageNamed:@"cell_bottom.png"];
//    } else {
//        background = [UIImage imageNamed:@"cell_middle.png"];
//    }
    
    return background;
    return selectionBackground;
}
 
*/
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  
   
    static NSString *CellIdentifier = @"Cell";
   CustomCell *cell = (CustomCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    // Configure the cell...
    if (cell == nil)
    {
        cell = [[CustomCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        

        
        UIImageView *ImageView = (UIImageView *)[cell viewWithTag:100];
        ImageView.image = [UIImage imageNamed:@"1385381109_iPhoto.png"];

    }

    
//    if (selectedImage)
//    {
//        UIImageView *ImageView = (UIImageView *)[cell viewWithTag:100];
//        ImageView.image = [UIImage imageNamed:@"1385381109_iPhoto.png"];
//    }
//    
    UIImageView *ImageView = (UIImageView *)[cell viewWithTag:100];
    ImageView.image = [UIImage imageNamed:@"1385381109_iPhoto.png"];

    
    // Display recipe in the table cell
   // Recipe *recipe = [recipes objectAtIndex:indexPath.row];
   //    UIImage *imageIcon = [UIImage imageNamed:@"full_breakfast.jpg"];
//    [cell.imageView setImage:imageIcon];
    
  
    cell.imageDelegate = self;
    
    NSInteger rowCount = [self tableView:[self tableView] numberOfRowsInSection:[indexPath section]];
    NSInteger rowIndex = indexPath.row;
    UIImage *background = nil;
    UIImage *selectionBackground = nil;
    
    if (rowIndex == 0 && rowIndex == rowCount - 1)
	{
		background = [UIImage imageNamed:@"topAndBottomRow.png"];
		selectionBackground = [UIImage imageNamed:@"topAndBottomRowSelected.png"];
	}
	else if (rowIndex == 0)
	{
		background = [UIImage imageNamed:@"topRow.png"];
		selectionBackground = [UIImage imageNamed:@"topRowSelected.png"];
	}
	else if (rowIndex == rowCount - 1)
	{
		background = [UIImage imageNamed:@"bottomRow.png"];
		selectionBackground = [UIImage imageNamed:@"bottomRowSelected.png"];
	}
	else
	{
		background = [UIImage imageNamed:@"middleRow.png"];
		selectionBackground = [UIImage imageNamed:@"middleRowSelected.png"];
	}
   
    UIImageView *cellBackgroundView = [[UIImageView alloc] initWithImage:background];
        cellBackgroundView.image = background;
        cell.backgroundView = cellBackgroundView;
    
    UIImageView *selBackgroundView = [[UIImageView alloc] initWithImage:selectionBackground];
    selBackgroundView.image = selectionBackground;
    cell.selectedBackgroundView = selBackgroundView;
    
   //  [((CustomCell *) aCell).selectButton setTag:indexPath.row];

//      [button addTarget:self action:@selector(myAction: ) forControlEvents:UIControlEventTouchUpInside];
   // cell.textLabel.text = [NSString stringWithFormat:@"Cell at row %d.",[indexPath row]];
    
    return cell;
}
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row%2 == 0) {
        UIColor *altCellColor = [UIColor colorWithWhite:0.7 alpha:0.1];
        cell.backgroundColor = altCellColor;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath

{
    NSLog(@"Row tapped at %i", [indexPath row]);
    
    self.custom.selectButton.tag = indexPath.row;
}



-(void)selectedCell:(UIImageView*)value

{
       chosenView=value;
    
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Select Image" message:@"" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Camera",@"Gallery", nil];
    [alert show];
 }



-(void)alertView:(UIAlertView *) alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0)
    {
       
    }
    else if (buttonIndex == 1)
    {
        
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
        {
            UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
            imagePicker.delegate = self;
            imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
            imagePicker.mediaTypes = [NSArray arrayWithObjects:(NSString *) kUTTypeImage,nil];
            imagePicker.allowsEditing = NO;
            aCell = (CustomCell *)chosenView.superview;
            //[self presentModalViewController:imagePicker animated:YES completion:nil];
            [self presentViewController:imagePicker animated:YES completion:nil];
            newMedia = YES;
        }
    }
    else if(buttonIndex == 2)
    {
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeSavedPhotosAlbum])
                {
                    UIImagePickerController *imagePicker =[[UIImagePickerController alloc] init];
                    imagePicker.delegate = self;
                    imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                    imagePicker.mediaTypes = [NSArray arrayWithObjects:(NSString *) kUTTypeImage, nil];
                    imagePicker.allowsEditing = NO;
//                    [self presentModalViewController:imagePicker animated:YES];
                    aCell = (CustomCell *)chosenView.superview;
                     [self presentViewController:imagePicker animated:YES completion:nil];
                    newMedia = NO;
                }
    }
}
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    
    
    
   
//    NSIndexPath *indexPath = [self.myTableView indexPathForCell:(CustomCell *) aCell];
    NSString *mediaType = [info objectForKey:UIImagePickerControllerMediaType];
   
    [self dismissViewControllerAnimated:YES completion:nil];
    if ([mediaType isEqualToString:(NSString *)kUTTypeImage])
    {
        UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
//
        selectedImage = image;
        
        UIImageView *ImageView = (UIImageView *)[aCell viewWithTag:100];

        ImageView.image = selectedImage;

//        [self.myTableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
//        [self.custom.imageView setImage:imageIcon];
        
        NSArray *indexPathArray = [NSArray arrayWithObject:[NSIndexPath indexPathForRow:1 inSection:0]];
        //You can add one or more indexPath in this array...
        
        [self.myTableView reloadRowsAtIndexPaths:indexPathArray withRowAnimation:UITableViewRowAnimationFade];
        if (newMedia)
            UIImageWriteToSavedPhotosAlbum(image,
                                           self,
                                           @selector(image:finishedSavingWithError:contextInfo:),
                                           nil);
    }
    else if ([mediaType isEqualToString:(NSString *)kUTTypeMovie])
    {
		// Code here to support video if enabled
	}
}
-(void)image:(UIImage *)image finishedSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    if (error)
    {
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle: @"Save failed"
                              message: @"Failed to save image"\
                              delegate: nil
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil];
        [alert show];
        
    }
}
-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
