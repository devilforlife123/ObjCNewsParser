//
//  NewsFetcher.m
//  ObjCNewsParser
//
//  Created by suraj poudel on 28/1/20.
//  Copyright © 2020 suraj poudel. All rights reserved.
//

#import "NewsFetcher.h"

@implementation NewsFetcher

-(void)searchNewsItemForURLString:(NSString*)searchURL withCompletionBlock:(NewsSearchCompletionBlock)completionBlock{
    
    
    __block NSMutableURLRequest *urlRequest = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:searchURL]];
    
    [urlRequest setHTTPMethod:@"GET"];
    
    __block NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    
    dispatch_async(dispatch_get_global_queue(QOS_CLASS_DEFAULT, 0), ^{
        NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:urlRequest completionHandler:^(NSData *data, NSURLResponse *response, NSError *error)
                                          {
                                              NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
                                              if(httpResponse.statusCode == 200)
                                              {
                                                  NSError *parseError = nil;
                                                  
                                                  NSString *strISOLatin = [[NSString alloc] initWithData:data encoding:NSISOLatin1StringEncoding];
                                                  NSData *dataUTF8 = [strISOLatin dataUsingEncoding:NSUTF8StringEncoding];
                                                  
                                                  NSDictionary *responseDictionary = [NSJSONSerialization JSONObjectWithData:dataUTF8 options:kNilOptions error:&parseError];
                                                  NSString * title = [responseDictionary objectForKey:@"title"];
                                              }
                                              else
                                              {
                                                  completionBlock(@"",nil,error);
                                              }
                                          }];
        [dataTask resume];
    });
}

@end
