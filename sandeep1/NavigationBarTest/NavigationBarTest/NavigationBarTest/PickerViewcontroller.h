//
//  PickerViewcontroller.h
//  NavigationBarTest
//
//  Created by Yokesh on 9/12/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PickerViewcontroller : UIViewController<UIPickerViewDataSource,UIPickerViewDelegate>{
    NSArray *countryNamesArray;
    
}
@property (nonatomic, retain) UIPickerView *pickerViewCountry;
@end
