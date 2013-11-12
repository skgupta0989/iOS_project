//
//  DeleteCurrentEmployee.h
//  UniversalEmployeeDBMSSystem
//
//  Created by Sandeep Kumar Gupta on 27/10/13.
//
//

#import <Foundation/Foundation.h>

@interface DeleteCurrentEmployee :  NSObject<NSURLConnectionDelegate>

- (BOOL)deleteRecord :(NSDictionary *)empRecord;
@end
