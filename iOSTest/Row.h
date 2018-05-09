//
//  Row.h
//  iOSTest
//
//  Created by Dnyaneshwar Balkrushna Wakchaure on 09/05/18.
//
//

#import <Foundation/Foundation.h>

@interface Row : NSObject

@property (strong, nonatomic) NSString * title;
@property (strong, nonatomic) NSString * desc;
@property (strong, nonatomic) NSString * imageHref;
- (instancetype) initWithDict:(NSDictionary *)dict ;
@end
