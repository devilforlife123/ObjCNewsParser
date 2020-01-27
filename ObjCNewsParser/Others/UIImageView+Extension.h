//
//  UIImageView+Extension.h
//  ObjCNewsParser
//
//  Created by suraj poudel on 28/1/20.
//  Copyright © 2020 suraj poudel. All rights reserved.
//


#import <UIKit/UIKit.h>

@interface UIImageView (Extension)

-(NSURLSessionDownloadTask*)loadImageWithURL:(NSURL*)url WithCompletion: (void(^)(UIImage*))completionBlock;

@end

