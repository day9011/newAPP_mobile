//
//  CommentTool.m
//  TFApp
//
//  Created by qujingkun on 16/6/14.
//  Copyright © 2016年 Joey. All rights reserved.
//

#import "CommentTool.h"
@interface CommentTool()
- (IBAction)editClick;

@end
@implementation CommentTool
-(void)awakeFromNib{
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (IBAction)editClick {
    self.editBlock ?  self.editBlock():nil;
}
@end
