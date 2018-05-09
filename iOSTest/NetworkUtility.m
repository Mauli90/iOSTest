//
//  NetworkUtility.m
//  iOSTest
//
//  Created by Dnyaneshwar Balkrushna Wakchaure on 04/05/18.
//
//

#import "NetworkUtility.h"

#define APIURL @"https://dl.dropboxusercontent.com/s/2iodh4vg0eortkl/facts.json"

@implementation NetworkUtility
+ (void)apiCallWithCompletion:(void (^)(NSDictionary *result, NSError *error))completion{

    NSURL *url = [NSURL URLWithString:APIURL];
    NSMutableURLRequest *requset = [[NSMutableURLRequest alloc] initWithURL:url];
    
    [NSURLConnection sendAsynchronousRequest:requset queue: [NSOperationQueue mainQueue] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
        
        NSData *jsonData = [NSData dataWithData:data];
        NSError *error = nil;
        
        NSString *str = [[NSString alloc] initWithData:jsonData encoding:NSISOLatin1StringEncoding];
        NSData * responseData = [str dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary * jsonObject = [NSJSONSerialization JSONObjectWithData:responseData options:kNilOptions error:&error];
        dispatch_async(dispatch_get_main_queue(), ^(void){
                completion(jsonObject, error);
        });
    }];
}

@end
