//
//  MessageFrameModel.m
//  Jared_QQMessage
//
//  Created by Jared on 16/5/24.
//  Copyright © 2016年 Jared. All rights reserved.
//

#import "MessageFrameModel.h"

#define markWidth [UIScreen mainScreen].bounds.size.width
@implementation MessageFrameModel

- (void)setModel:(MessageModel *)model{
    _model = model;
    CGFloat space = 10;
    // 时间
    CGFloat timeX = 0;
    CGFloat timeY = timeX;
    CGFloat timeW = markWidth;
    CGFloat timeH = 30;
    if (!model.isHidentime) {
        self.timeFrame = CGRectMake(timeX, timeY, timeW, timeH);
    }
    //头像
    CGFloat iconW = 60;
    CGFloat iconH = 60;
    CGFloat iconY = CGRectGetMaxY(self.timeFrame) + space;
    CGFloat iconX;
    if (model.type == MessageModelTypeSelf) {
        iconX = markWidth - iconW - space;
    }else{
        iconX = space;
    }
    self.iconFrame = CGRectMake(iconX, iconY, iconW, iconH);
    // 内容
    CGSize textSize = [self sizeWithString:model.text withFont:[UIFont systemFontOfSize:14.0] maxSize:CGSizeMake(markWidth - 160, MAXFLOAT)];
    CGSize buttonSize = CGSizeMake(textSize.width + 20*2, textSize.height + 20*2);
    CGFloat messageBtnY = iconY;
    CGFloat messageBtnX;
    if (model.type == MessageModelTypeSelf) {
        messageBtnX = markWidth - 2*space - iconW - buttonSize.width;
    }else {
        messageBtnX = CGRectGetMaxX(self.iconFrame) + space;
    }
    
    self.messageFrame = CGRectMake(messageBtnX, messageBtnY, buttonSize.width, buttonSize.height);
    
    //计算好高
    CGFloat iconMaxY = CGRectGetMaxY(self.iconFrame);
    CGFloat messageBtnMaxY = CGRectGetMaxY(self.messageFrame);
    self.rowHeight = MAX(iconMaxY, messageBtnMaxY) + space;

}

// 计算行高

- (CGSize)sizeWithString:(NSString *)text withFont:(UIFont *)font maxSize:(CGSize)maxSize{
    NSDictionary *dic = @{NSFontAttributeName:font};
    CGSize size = [text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil].size;
    return size;
}

@end
