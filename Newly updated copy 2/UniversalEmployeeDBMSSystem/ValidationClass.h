//
//  ValidationClass.h
//  UniversalEmployeeDBMSSystem
//
//  Created by Yokesh on 10/6/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface ValidationClass : NSObject




+(BOOL)validateFields:(NSString*)empId:(NSString*)empName:(NSString*)empDOJ:(NSString*)empDOB:(NSString*)empEmailId:(NSString*)empContactNo:(NSString*)empAddress :(NSString *) empRole;
@end
