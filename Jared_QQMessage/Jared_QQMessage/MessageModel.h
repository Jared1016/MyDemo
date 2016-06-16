//
//  MessageModel.h
//  Jared_QQMessage
//
//  Created by Jared on 16/5/24.
//  Copyright © 2016年 Jared. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum{
    MessageModelTypeSelf,
    MessageModelTypeOther
    
}MessageModelType;
@interface MessageModel : NSObject

// 正文
@property (nonatomic, copy)NSString *text;
//时间
@property (nonatomic, copy)NSString *time;
//是否为自己
@property (nonatomic, assign) MessageModelType type;

//是否隐藏时间
@property (nonatomic, assign, getter=isHidentime)BOOL hidenTime;

- (instancetype)initWithNSDictionary:(NSDictionary *)dic;

+ (instancetype)MessageModelWithDictionary:(NSDictionary *)dic;

+ (NSArray *)messageList;


@end
