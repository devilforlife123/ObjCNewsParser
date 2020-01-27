//
//  UIImageView+Extension.m
//  ObjCNewsParser
//
//  Created by suraj poudel on 28/1/20.
//  Copyright © 2020 suraj poudel. All rights reserved.
//

#import "UIImageView+Extension.h"

@implementation UIImageView (Extension)

-(NSURLSessionDownloadTask*)loadImageWithURL:(NSURL*)url WithCompletion: (void(^)(UIImage*))completionBlock{
    
    __block NSURLSession * session = [NSURLSession sharedSession];
    __block NSURLSessionDownloadTask * downloadTask;
    
    
    dispatch_async(dispatch_get_global_queue(QOS_CLASS_DEFAULT, 0), ^{
        __weak UIImageView * weakSelf = self;
         downloadTask = [session downloadTaskWithURL:url completionHandler:^(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            
            if(error){
                completionBlock(nil);
                return;
            }else{
                NSData * data = [[NSData alloc]initWithContentsOfURL:location];
                UIImage * image = [[UIImage alloc]initWithData:data];
                if(image == nil){
                    completionBlock(nil);
                                 return;
                }else{
                    dispatch_async(dispatch_get_main_queue(), ^{
                        weakSelf.image = image;
                        completionBlock(image);
                    });
                }
            }
            
        }];
        
        [downloadTask resume];
    });
    
    return downloadTask;
    
    
    
}


@end
