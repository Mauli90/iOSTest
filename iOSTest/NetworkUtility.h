//
//  NetworkUtility.h
//  iOSTest
//
//  Created by Dnyaneshwar Balkrushna Wakchaure on 04/05/18.
//
//

#import <Foundation/Foundation.h>

@interface NetworkUtility : NSObject
+ (void)apiCallWithCompletion:(void (^)(NSDictionary *result, NSError *error))completion;

@end
