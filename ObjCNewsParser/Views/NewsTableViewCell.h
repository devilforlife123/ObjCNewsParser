//
//  NewsTableViewCell.h
//  ObjCNewsParser
//
//  Created by suraj poudel on 28/1/20.
//  Copyright © 2020 suraj poudel. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "News.h"

@interface NewsTableViewCell : UITableViewCell

-(instancetype)initWithReuseIdentifier:(NSString*)reuseIdentifier;
@property (strong, nonatomic) UIImageView *thumbnailImageView;
@property (strong, nonatomic) UILabel *headlineLabel;
@property (strong, nonatomic) UILabel *sluglineLabel;
@property(nonatomic,strong)News * news;

@end
