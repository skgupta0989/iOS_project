//
//  NetworkConnectivity.h
//  UniversalEmployeeDBMSSystem
//
//  Created by Yokesh on 10/7/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Reachability.h"
@interface NetworkConnectivity : NSObject
{
    Reachability *reachability;
}

- (BOOL) checkConnection ;
//- (void)fetchedData:(NSData *)responseData;
//-(void) startSynchronizing;
@end
