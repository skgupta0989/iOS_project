//
//  DataAdapterEmployeeList.m
//  UniversalEmployeeDBMSSystem
//
//  Created by Yokesh on 10/25/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "DataAdapterEmployeeList.h"
#import "LoadRemoteDataClass.h"

@implementation DataAdapterEmployeeList

CWL_SYNTHESIZE_SINGLETON_FOR_CLASS(DataAdapterEmployeeList);

@synthesize firstArray,secondArray,thirdArray;
@synthesize theRecord;
    

//-(void) removeLeastRecentlyUsed: (int)start range:(int)size
//{
//    
//    //NSUInteger count = [self.theContainer count];
//    int i= size;
//    while(i--)
//    {
//        [self.theContainer removeObjectAtIndex:start];
//    }
//
//}



-(void)copyContentFromThird
{
    self.firstArray = [[NSMutableArray alloc]initWithArray:secondArray];
    self.secondArray = [[NSMutableArray alloc]initWithArray:thirdArray];
}



-(void)copyContentFromFirst
{
    self.thirdArray = [[NSMutableArray alloc]initWithArray:secondArray];
    
    self.secondArray = [[NSMutableArray alloc]initWithArray:firstArray];
}



- (BOOL) loadContents:(NSNumber *)_max nextOffset :(NSNumber *) _offset :(int)_direction
{
    LoadRemoteDataClass *loadRemoteData = [[LoadRemoteDataClass alloc] init];
    if(_direction == 1)
    {
        
       [self copyContentFromThird];
        BOOL result = [loadRemoteData getRemoteDataNext :_max:_offset];
        if(result == NO)
        {
            return  NO;
        
        
        }
        else
        {
                        
            return YES;
        }
        
    
    
    }
    else if(_direction == -1)
    {
           
        [self copyContentFromFirst];
        BOOL result = [loadRemoteData getRemoteDataPrevious :_max:_offset];
        if(result == NO)
        {
            return  NO;
            
            
        }
        else
        {
            //[self copyContentFromFirst];
            return YES;
        }

        
    }
}


@end
