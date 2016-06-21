//
//  TieziCell.m
//  TFApp
//
//  Created by qujingkun on 16/6/14.
//  Copyright © 2016年 Joey. All rights reserved.
//

#import "TieziCell.h"
@interface TieziCell()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *authorLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *abstractLabel;
@end
@implementation TieziCell
-(void)setTiezi:(CusTiezi *)tiezi{
    _tiezi=tiezi;
    self.titleLabel.text=tiezi.title;
    self.authorLabel.text=tiezi.author;
    self.timeLabel.text=tiezi.commit_time;
    self.abstractLabel.text=tiezi.abstract;
    
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
