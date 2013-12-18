//
//  TableViewViewController.h
//  CameraClass
//
//  Created by Sandeep Kumar Gupta on 19/11/13.
//  Copyright (c) 2013 Sandeep Kumar Gupta. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ImageTableViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *tableView;
    UIImageView *imageView;
     UIImageView *imageView1;
}

@property(nonatomic,strong)IBOutlet UITableView *tableView;
@property(nonatomic,strong)IBOutlet UIImageView *imageView;
@property(nonatomic,strong)IBOutlet UIImageView *imageView1;
@end
