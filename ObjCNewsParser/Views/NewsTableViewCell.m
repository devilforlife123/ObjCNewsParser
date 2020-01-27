//
//  NewsTableViewCell.m
//  ObjCNewsParser
//
//  Created by suraj poudel on 28/1/20.
//  Copyright © 2020 suraj poudel. All rights reserved.
//

#import "NewsTableViewCell.h"
#import "Constants.h"
#import "UIImageView+Extension.h"

@interface NewsTableViewCell () {
    
    NSURLSessionDownloadTask * downloadTask;

}
@end

@implementation NewsTableViewCell


- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reuseIdentifier];
    
    [self addSubViewAndSetupConstraints];
    
    return self;
}

-(void)addSubViewAndSetupConstraints{
    
        UILayoutGuide * marginGuide =  [self.contentView layoutMarginsGuide];
        self.thumbnailImageView  = [[UIImageView alloc] init];
        [self.contentView addSubview:self.thumbnailImageView];
        self.thumbnailImageView.translatesAutoresizingMaskIntoConstraints = false;
        [[self.thumbnailImageView.leadingAnchor constraintEqualToAnchor:marginGuide.leadingAnchor]setActive:YES];
        [[self.thumbnailImageView.bottomAnchor constraintLessThanOrEqualToAnchor:marginGuide.bottomAnchor constant:5]setActive:YES];
        [[self.thumbnailImageView.topAnchor constraintEqualToAnchor:marginGuide.topAnchor]setActive:YES];
        [[self.thumbnailImageView.heightAnchor constraintEqualToConstant:80]setActive:YES];
        [[self.thumbnailImageView.widthAnchor constraintEqualToConstant:80]setActive:YES];

       self.headlineLabel= [[UILabel alloc] init];
       self.headlineLabel.font = [UIFont boldSystemFontOfSize:NewsCellheadlineFontSize];
       self.headlineLabel.textColor = kCustomRedColor;
       self.headlineLabel.numberOfLines = 0;
       [self.contentView addSubview:self.headlineLabel];
       self.headlineLabel.translatesAutoresizingMaskIntoConstraints = false;
       [[self.headlineLabel.leadingAnchor constraintEqualToAnchor:self.thumbnailImageView.trailingAnchor constant:10]setActive:YES];
       [[self.headlineLabel.topAnchor constraintEqualToAnchor:marginGuide.topAnchor]setActive:YES];
       [[self.headlineLabel.trailingAnchor constraintLessThanOrEqualToAnchor:marginGuide.trailingAnchor constant:5]setActive:YES];
       
       self.sluglineLabel = [[UILabel alloc] init];
       self.sluglineLabel.font = [UIFont systemFontOfSize:NewsCellSluglineFontSize];
       self.sluglineLabel.textColor = [UIColor blackColor];
       self.sluglineLabel.numberOfLines = 0;
       [self.contentView addSubview:self.sluglineLabel];
        self.sluglineLabel.translatesAutoresizingMaskIntoConstraints = false;
        [[self.sluglineLabel.leadingAnchor constraintEqualToAnchor:self.thumbnailImageView.trailingAnchor constant:10]setActive:YES];
        [[self.sluglineLabel.bottomAnchor constraintLessThanOrEqualToAnchor:marginGuide.bottomAnchor constant:5]setActive:YES];
        [[self.sluglineLabel.topAnchor constraintEqualToAnchor:self.headlineLabel.bottomAnchor]setActive:YES];
       [[self.sluglineLabel.trailingAnchor constraintLessThanOrEqualToAnchor:marginGuide.trailingAnchor constant:5]setActive:YES];
    
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

-(void)prepareForReuse{
    
    [super prepareForReuse];
    
    downloadTask = nil;
    self.sluglineLabel.text = nil;
    self.headlineLabel.text = nil;
    self.thumbnailImageView.image = nil;
}

-(void)setNews:(News*)news andCache:(NSCache*)cache{
    self.sluglineLabel.text = news.slugline;
    self.headlineLabel.text = news.headline;
    if(![news.thumbnailURL isEqual:[NSNull null]]){
      UIImage * image = [cache objectForKey:news.thumbnailURL];
            if(image != nil){
                [self.thumbnailImageView setImage:image];
            }else{
                downloadTask = [self.thumbnailImageView loadImageWithURL:[NSURL URLWithString:news.thumbnailURL] WithCompletion:^(UIImage * image) {
                    if(image != nil){
                        [cache setObject:image forKey:news.thumbnailURL];
                    }else{
                        [cache setObject:[UIImage imageNamed:@"placeholder"] forKey:news.thumbnailURL];
                    }
                }];
            }
        
    }else{
         [self.thumbnailImageView setImage:[UIImage imageNamed:@"placeholder"]];
        
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];

}


@end
