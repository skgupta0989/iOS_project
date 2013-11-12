//
//  SynchronizationClass.h
//  UniversalEmployeeDBMSSystem
//
//  Created by Yokesh on 10/8/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SynchronizationClass : NSObject<NSURLConnectionDelegate>{
    NSMutableArray *jason;
    NSString *selectedEmpId;
    NSString *selectedEmailId;
    
}
@property(nonatomic, strong)NSString *selectedEmpId;
@property (nonatomic, strong) NSMutableData *responseData;
- (BOOL)loadURL :(NSDictionary *)empRecord ;
@end



//@interface spike1ViewController()

//@end