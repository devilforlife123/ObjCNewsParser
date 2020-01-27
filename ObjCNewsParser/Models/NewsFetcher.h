//
//  NewsFetcher.h
//  ObjCNewsParser
//
//  Created by suraj poudel on 28/1/20.
//  Copyright © 2020 suraj poudel. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef void(^NewsSearchCompletionBlock)(NSString*title,NSArray * newsArray,NSError * error);

@interface NewsFetcher : NSObject

-(void)searchNewsItemForURLString:(NSString*)urlString withCompletionBlock:(NewsSearchCompletionBlock)completionBlock;

@end
