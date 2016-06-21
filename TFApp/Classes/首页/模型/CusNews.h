//
//  CusNews.h
//  自己的百思
//
//  Created by qujingkun on 16/2/24.
//  Copyright © 2016年 USTC. All rights reserved.
//
//"cursor": 2,
//"source": "新浪娱乐",
//"url": "http://ent.sina.com.cn/s/h/2016-03-21/doc-ifxqnski7779071.shtml",
//"keywords": "ella,贾乃亮,李娜",
//"title": "节目Ella首秀体育天赋 嘉桦再创“佳话”",
//"date": "201603211007",
//"abstract": "新浪娱乐讯由浙江卫视和蓝天下传媒联合出品的大型励志竞技体育综艺节目《来吧冠军》即将在每周日晚和大家见面。",
//"content": "",
//"image": "http://n.sinaimg.cn/ent/transform/20160321/KzlS-fxqnskh1040864.jpg",
//"id": "fxqnski7779071"
#import <Foundation/Foundation.h>
#import "CusContents.h"
@interface CusNews : NSObject
@property(nonatomic,copy)NSString *date;
@property(nonatomic,copy)NSString *source;
@property(nonatomic,copy)NSString *url;
@property(nonatomic,copy)NSString *ID;
@property(nonatomic,copy)NSString *title;
@property(nonatomic,copy)NSString *abstract;
@property(nonatomic,copy)NSString *image;

@end
