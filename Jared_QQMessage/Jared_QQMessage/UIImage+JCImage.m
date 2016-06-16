//
//  UIImage+JCImage.m
//  JCMessageQQ
//
//  Created by QB on 16/5/9.
//  Copyright © 2016年 JC. All rights reserved.
//

#import "UIImage+JCImage.h"

@implementation UIImage (JCImage)

///缩放图片
+ (instancetype)resizeImage:(NSString *)imgName {
    
    UIImage *backImage = [UIImage imageNamed:imgName];
    //缩放图片
    backImage =  [backImage stretchableImageWithLeftCapWidth:backImage.size.width / 2 topCapHeight:backImage.size.height / 2];
    return backImage;
}

@end
