
#import "UIImageView+Extension.h"
#import <UIImageView+WebCache.h>

@implementation UIImageView (Extension)

- (void)setHeaderWithURL:(NSURL *)url {
    
    UIImage *placeholder = [[UIImage imageNamed:@"defaultUserHeader"] circleImage];
    
    [self sd_setImageWithURL:url
            placeholderImage:placeholder
                   completed:^(UIImage *image,
                               NSError *error,
                               SDImageCacheType cacheType,
                               NSURL *imageURL) {
        self.image = image ? [image circleImage] : placeholder;
    }];
    
}

@end
