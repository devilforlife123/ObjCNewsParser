//
//  News.h
//  ObjCNewsParser
//
//  Created by suraj poudel on 28/1/20.
//  Copyright © 2020 suraj poudel. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface News : NSObject

@property(nonatomic,copy)NSString * headline;
@property(nonatomic,copy)NSString * slugline;
@property(nonatomic,copy)NSString * thumbnailURL;

@end

