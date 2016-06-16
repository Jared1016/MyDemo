//
//  MessageTableViewCell.m
//  Jared_QQMessage
//
//  Created by Jared on 16/5/24.
//  Copyright © 2016年 Jared. All rights reserved.
//

#import "MessageTableViewCell.h"
#import "MessageModel.h"

#import "UIImage+JCImage.h"
@interface MessageTableViewCell ()
///时间
@property (nonatomic, weak) UILabel *timeLabel;
///信息
@property (nonatomic, weak) UIButton *messageBtn;
///头像
@property (nonatomic, weak) UIImageView *iconView;


@end
@implementation MessageTableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    static NSString *identifier = @"cell";
    MessageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[MessageTableViewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:identifier];
    }
    
    return cell;
    
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupCell];
    }
    return self;
}

- (void)setupCell{
    
    self.backgroundColor = [UIColor clearColor];
    UILabel *timeLabel = [[UILabel alloc] init];
    timeLabel.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:timeLabel];
    self.timeLabel = timeLabel;
    
    //信息
    UIButton *messageBtn = [[UIButton alloc] init];
    messageBtn.titleLabel.font = [UIFont systemFontOfSize:14.0];
    messageBtn.titleLabel.numberOfLines = 0;
    [messageBtn setTitleColor:[UIColor blackColor] forState:0];
    //设置内边距
    messageBtn.contentEdgeInsets = UIEdgeInsetsMake(20, 20, 20, 20);
    [self.contentView addSubview:messageBtn];
    self.messageBtn = messageBtn;
    //头像
    UIImageView *iconView = [[UIImageView alloc] init];
    //设置圆形
    iconView.layer.cornerRadius = 30;
    iconView.layer.masksToBounds = YES;
    [self.contentView addSubview:iconView];
    self.iconView = iconView;
    self.iconView.backgroundColor = [UIColor greenColor];
    
}

- (void)setFrameModel:(MessageFrameModel *)frameModel{
    _frameModel = frameModel;
    self.timeLabel.text = frameModel.model.time;
    self.timeLabel.frame = frameModel.timeFrame;
    //头像
    if (frameModel.model.type == MessageModelTypeSelf) {
        self.iconView.image = [UIImage imageNamed:@"me"];
    } else {
        self.iconView.image = [UIImage imageNamed:@"other"];
        self.iconView.backgroundColor = [UIColor greenColor];
    }
    
    self.iconView.frame = frameModel.iconFrame;
    
    //消息
    [self.messageBtn setTitle:frameModel.model.text forState:0];
    self.messageBtn.frame = frameModel.messageFrame;
    //设置背景图片
    if (frameModel.model.type == MessageModelTypeSelf) {
        [self.messageBtn setBackgroundImage:[UIImage resizeImage:@"chat_send_nor"] forState:0];
        [self.messageBtn setBackgroundImage:[UIImage resizeImage:@"chat_send_press_pic"] forState:UIControlStateHighlighted];
    } else {
        [self.messageBtn setBackgroundImage:[UIImage resizeImage:@"chat_recive_nor"] forState:0];
        [self.messageBtn setBackgroundImage:[UIImage resizeImage:@"chat_recive_press_pic"] forState:UIControlStateHighlighted];
    }

}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
