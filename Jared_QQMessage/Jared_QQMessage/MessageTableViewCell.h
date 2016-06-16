//
//  MessageTableViewCell.h
//  Jared_QQMessage
//
//  Created by Jared on 16/5/24.
//  Copyright © 2016年 Jared. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MessageFrameModel.h"
#import "MessageModel.h"
@interface MessageTableViewCell : UITableViewCell

@property (nonatomic, strong)MessageModel *model;
@property (nonatomic, strong)MessageFrameModel *frameModel;

+ (instancetype)cellWithTableView:(UITableView *)tableView;
@end
