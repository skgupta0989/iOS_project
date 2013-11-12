//
//  DataAdapterEmployeeList.h
//  UniversalEmployeeDBMSSystem
//
//  Created by Yokesh on 10/25/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CWLSynthesizeSingleton.h"
@interface DataAdapterEmployeeList : NSObject
{
    NSMutableDictionary *theRecord;
    NSMutableArray *firstArray,*secondArray,*thirdArray;
}

CWL_DECLARE_SINGLETON_FOR_CLASS(DataAdapterEmployeeList);



@property (strong, nonatomic) NSMutableDictionary *theRecord;
@property (strong, atomic) NSMutableArray *firstArray,*secondArray,*thirdArray;

- (BOOL) loadContents:(NSNumber *)_max nextOffset :(NSNumber *) _offset :(int)_direction;
//-(void) removeLeastRecentlyUsed: (int)start range:(int)size;
-(void)copyContentFromThird;
-(void)copyContentFromFirst;
@end
