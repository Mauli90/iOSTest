//
//  Response.m
//  iOSTest
//
//  Created by Dnyaneshwar Balkrushna Wakchaure on 09/05/18.
//
//

#import "Response.h"

@implementation Response

- (instancetype) initWithJson:(NSDictionary *)jsonObject {
    
    self = [super init];
    
    if (self) {
        self.title = [jsonObject valueForKey:@"title"];
        self.rows = [[NSMutableArray alloc] init];
        NSArray * arr = [jsonObject valueForKey:@"rows"];
        for (NSDictionary * row in arr) {
            [self.rows addObject:[[Row alloc] initWithDict:row]];
        }
    }
    return self;
}

@end
