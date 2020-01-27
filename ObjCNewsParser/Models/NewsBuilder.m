//
//  NewsBuilder.m
//  ObjCNewsParser
//
//  Created by suraj poudel on 28/1/20.
//  Copyright © 2020 suraj poudel. All rights reserved.
//
#import "NewsBuilder.h"
#import "News.h"

@implementation NewsBuilder

+(NSArray*)newsFromJSON:(id)jsonObject{
    
    NSMutableArray * newsArray = [NSMutableArray new];
    NSArray * results = [jsonObject valueForKey:@"rows"];
    for (NSDictionary * newsDict in results){
        News * news = [[News alloc]init];
        NSString * headlineString = [newsDict objectForKey:@"title"];
        NSString * descriptionString = [newsDict objectForKey:@"description"];
        if(![headlineString isEqual:[NSNull null]]){
            if(![headlineString isEqualToString:@""]){
                news.headline = [newsDict objectForKey:@"title"];
            }else{
                news.headline = @"No title Available";
            }
        }else{
            news.headline = @"No title Available";
        }
        if(![descriptionString isEqual:[NSNull null]]){
            if(![descriptionString isEqualToString:@""]){
                news.slugline = [newsDict objectForKey:@"description"];
            }else{
                news.slugline = @"No title Available";
            }
        }else{
            news.slugline = @"No description Available";
        }
        news.thumbnailURL = [newsDict objectForKey:@"imageHref"];
        [newsArray addObject:news];
    }
    
    return newsArray;
}

@end
