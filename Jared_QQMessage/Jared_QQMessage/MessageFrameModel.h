//
//  MessageFrameModel.h
//  Jared_QQMessage
//
//  Created by Jared on 16/5/24.
//  Copyright © 2016年 Jared. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "MessageModel.h"
@interface MessageFrameModel : NSObject

//数据模型
@property (nonatomic, strong)MessageModel *model;

//时间
@property (nonatomic, assign) CGRect timeFrame;

//消息
@property (nonatomic, assign) CGRect messageFrame;

//头像
@property (nonatomic, assign) CGRect iconFrame;
//行高
@property (nonatomic, assign) CGFloat rowHeight;

@end
