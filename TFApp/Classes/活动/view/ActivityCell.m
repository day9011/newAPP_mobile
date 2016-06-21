//
//  ActivityCell.m
//  TFApp
//
//  Created by qujingkun on 16/6/15.
//  Copyright © 2016年 Joey. All rights reserved.
//

#import "ActivityCell.h"
#import "UIImageView+WebCache.h"
@interface ActivityCell()
@property (weak, nonatomic) IBOutlet UIImageView *iconImage;
@property (weak, nonatomic) IBOutlet UILabel *themeLabel;
@property (weak, nonatomic) IBOutlet UILabel *abstractLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *adressLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@end
@implementation ActivityCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)setActivity:(CusActivity *)activity{
    _activity=activity;
    [self.iconImage sd_setImageWithURL:[NSURL URLWithString:_activity.img] placeholderImage:[UIImage imageNamed:@"qiao"]];
    
    self.themeLabel.text=_activity.theme;
    self.abstractLabel.text=_activity.abstract;
    self.timeLabel.text=_activity.time;
    self.adressLabel.text=_activity.adress;
    self.priceLabel.text=[NSString stringWithFormat:@"价格：%@",_activity.price];
}
@end
