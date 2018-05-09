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
//    NSString *htmlBody = [NSString stringWithFormat:@""];
//    
//    NSMutableString *httpBodyString=[[NSMutableString alloc] initWithString:htmlBody];
//    NSString* string = APIURL;
//    NSURL *url = [NSURL URLWithString:[string localizedNameOfStringEncoding:NSISOLatin1StringEncoding]];
//    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
//    [request setHTTPBody:[httpBodyString dataUsingEncoding:NSISOLatin1StringEncoding]];
//
//    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue currentQueue]
//                           completionHandler: ^(NSURLResponse * response, NSData * data, NSError * error) {
//                               NSHTTPURLResponse * httpResponse = (NSHTTPURLResponse*)response;
//                               if(httpResponse.statusCode == 200) {
//                                   
//                                   NSDictionary * jsonObject = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
//                                   dispatch_async(dispatch_get_main_queue(), ^(void){
//                                       completion(jsonObject, error);
//                                   });
//                               }else{
//                                   dispatch_async(dispatch_get_main_queue(), ^(void){
//                                       completion(nil, error);
//                                   });
//                               }
//                           }
//     ];

    
    dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(void){
        NSError *error;
        NSString *string = [NSString stringWithContentsOfURL: [NSURL URLWithString: APIURL] encoding:NSISOLatin1StringEncoding error:&error];
        if(string != nil){
            NSData * responseData = [string dataUsingEncoding:NSUTF8StringEncoding];
            NSDictionary * jsonObject = [NSJSONSerialization JSONObjectWithData:responseData options:kNilOptions error:&error];
            dispatch_async(dispatch_get_main_queue(), ^(void){
                completion(jsonObject, error);
            });
            
        }else{
            dispatch_async(dispatch_get_main_queue(), ^(void){
                completion(nil, error);
            });
        }
    });
    
}

@end
