//
//  MessageModel.m
//  Jared_QQMessage
//
//  Created by Jared on 16/5/24.
//  Copyright © 2016年 Jared. All rights reserved.
//

#import "MessageModel.h"

@implementation MessageModel
- (instancetype)initWithNSDictionary:(NSDictionary *)dic{
    
    self = [super init];
    if (self) {
        [self setValuesForKeysWithDictionary:dic];
    }
    return self;
    
}

+ (instancetype)MessageModelWithDictionary:(NSDictionary *)dic{
    return [[self alloc] initWithNSDictionary:dic];
}

+ (NSArray *)messageList{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"messages" ofType:@"plist"];
    NSArray *messageArray = [NSArray arrayWithContentsOfFile:path];
    NSMutableArray *newMessageArray = [NSMutableArray arrayWithCapacity:messageArray.count];
    for (NSDictionary *tempDic in messageArray) {
        MessageModel *model = [MessageModel MessageModelWithDictionary:tempDic];
        [newMessageArray addObject:model];
    }
    return newMessageArray;
}
@end
