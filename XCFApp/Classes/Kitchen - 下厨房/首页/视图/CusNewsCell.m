//
//  CusNewsCell.m
//  自己的百思
//
//  Created by qujingkun on 16/2/24.
//  Copyright © 2016年 USTC. All rights reserved.
//

#import "CusNewsCell.h"
#import "UIImageView+WebCache.h"
@interface CusNewsCell()
@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *detailLabel;

@end
@implementation CusNewsCell

- (void)awakeFromNib {
    // Initialization code
}
-(void)setNews:(CusNews *)news{
    _news=news;
    //CusLog(@"%@",news.title);
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:_news.image] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
    self.titleLabel.text=_news.title;
    self.detailLabel.text=_news.abstract;
}
//- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
//    [super setSelected:selected animated:animated];
//
//    // Configure the view for the selected state
//}

@end
