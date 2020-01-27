//
//  NewsBuilder.h
//  ObjCNewsParser
//
//  Created by suraj poudel on 28/1/20.
//  Copyright © 2020 suraj poudel. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NewsBuilder : NSObject

+(NSArray*)newsFromJSON:(id)jsonObject;

@end

