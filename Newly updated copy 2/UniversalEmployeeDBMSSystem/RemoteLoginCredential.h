//
//  RemoteLoginCredential.h
//  UniversalEmployeeDBMSSystem
//
//  Created by Yokesh on 10/18/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CWLSynthesizeSingleton.h"
@interface RemoteLoginCredential : NSObject


CWL_DECLARE_SINGLETON_FOR_CLASS(RemoteLoginCredential);
-(int)checkCredential:(NSString *) userName : (NSString *) passWord;
@end
