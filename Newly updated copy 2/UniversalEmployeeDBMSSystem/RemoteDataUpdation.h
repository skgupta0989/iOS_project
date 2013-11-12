//
//  RemoteDataUpdation.h
//  UniversalEmployeeDBMSSystem
//
//  Created by Yokesh on 10/24/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RemoteDataUpdation : NSObject<NSURLConnectionDelegate>

- (BOOL)updateRecord :(NSDictionary *)empRecord;
@end
