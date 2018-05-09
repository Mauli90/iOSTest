//
//  Row.m
//  iOSTest
//
//  Created by Dnyaneshwar Balkrushna Wakchaure on 09/05/18.
//
//

#import "Row.h"

@implementation Row
- (instancetype) initWithDict:(NSDictionary *)dict {
    
    self = [super init];
    
    if (self) {
        self.title = @"";
        self.desc = @"";
        self.imageHref = @"placeholder.png";
        
        if(![[dict valueForKey:@"title"] isKindOfClass:[NSNull class]])
         self.title = [dict valueForKey:@"title"];
        if(![[dict valueForKey:@"description"] isKindOfClass:[NSNull class]])
         self.desc = [dict valueForKey:@"description"];
        if(![[dict valueForKey:@"imageHref"] isKindOfClass:[NSNull class]])
         self.imageHref = [dict valueForKey:@"imageHref"];
    }
    return self;
}

@end
