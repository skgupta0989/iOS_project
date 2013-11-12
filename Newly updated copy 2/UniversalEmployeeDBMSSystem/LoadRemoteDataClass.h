//
//  LoadRemoteDataClass.h
//  UniversalEmployeeDBMSSystem
//
//  Created by Yokesh on 10/9/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LoadRemoteDataClass :NSObject<NSURLConnectionDelegate>
{
    NSMutableArray *empRecordArray;
    NSMutableData *responseData;
    NSMutableDictionary *jason;
}
-(BOOL)getRemoteDataNext:(NSNumber*)max :(NSNumber*)offset;
-(BOOL)getRemoteDataPrevious:(NSNumber*)max :(NSNumber*)offset;
@property (strong, nonatomic) NSMutableArray *empRecordArray;
@end
