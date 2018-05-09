//
//  Response.h
//  iOSTest
//
//  Created by Dnyaneshwar Balkrushna Wakchaure on 09/05/18.
//
//

#import <Foundation/Foundation.h>

@interface Response : NSObject

@property (strong, nonatomic) NSString * title;
@property (strong, nonatomic) NSArray * rows;

- (instancetype) initWithJson:(NSDictionary *)jsonObject;
@end
