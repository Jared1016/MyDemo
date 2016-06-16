//
//  MessageViewController.m
//  Jared_QQMessage
//
//  Created by Jared on 16/5/23.
//  Copyright © 2016年 Jared. All rights reserved.
//

#import "MessageViewController.h"
#import "MessageTableViewCell.h"
#import "MessageModel.h"
#import "MessageFrameModel.h"
@interface MessageViewController ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>
@property (nonatomic, strong) NSMutableArray *messageArrayList;
@end

@implementation MessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blueColor];
    //添加通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyBoard)];
    [self.view addGestureRecognizer:tap];
    
//    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//    self.tableView.allowsSelection = NO;
    self.tableView.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1];
    
//    self.tableView.backgroundColor = [UIColor redColor];
    [self.tableView registerNib:[UINib nibWithNibName:@"MessageTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    NSLog(@"%lu", _messageArrayList.count);
}

//懒加载
- (NSMutableArray *)messageArrayList{
    if (!_messageArrayList) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"message.list" ofType:nil];
        NSArray *array = [NSArray arrayWithContentsOfFile:path];
        NSMutableArray *messgeArray = [NSMutableArray arrayWithCapacity:array.count];
        MessageModel *lastMessage;
        for (NSDictionary *dic in array) {
            MessageModel *model = [MessageModel MessageModelWithDictionary:dic];
            if ([model.time isEqualToString:lastMessage.time]) {
                model.hidenTime = YES;
            }
            MessageFrameModel *frameModel = [[MessageFrameModel alloc] init];
            frameModel.model = model;
            [messgeArray addObject:frameModel];
        }
        _messageArrayList = messgeArray;
        
    }
    return _messageArrayList;
}

// 改变frame  通知keyBoardWillChangeFrame
- (void)keyBoardWillChangeFrame:(NSNotification *)notification{
    //键盘弹出的时间
    CGFloat duration = [notification.userInfo[@"UIKeyboardAnimationDurationUserInfoKey"]floatValue];
    NSLog(@"duration:%f",duration);
    //获取键盘高度
    CGRect frame = [notification.userInfo[@"UIKeyboardFrameEndUserInfoKey"]CGRectValue];
    NSLog(@"frame:%@",NSStringFromCGRect(frame));
    
    CGFloat offsetY = frame.origin.y - self.view.frame.size.height;
    /**
     *  键盘弹出动画
     *
     *  @param duration 键盘弹出的时间
     *
     *  @param offsetY  View的偏移量
     */
    [UIView animateWithDuration:duration animations:^{
        self.view.transform = CGAffineTransformMakeTranslation(0, offsetY);
    }];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
//    return self.messageArrayList.count;
    return 20;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
//    MessageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
//    if (!cell){
//        cell = [[MessageTableViewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:@"cell"];
//    }
    MessageTableViewCell *cell = [MessageTableViewCell cellWithTableView:self.tableView];
//    cell.frameModel = self.messageArrayList[indexPath.row];
    cell.textLabel.text = @"....";
    return cell;
}

- (void)hideKeyBoard{
    [self.messageField resignFirstResponder];
}

#pragma mark ---textField代理
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    NSString *message = textField.text;
    [self sendMessage:message type:MessageModelTypeSelf];
    if ([message isEqualToString:@"你好"]) {
        [self sendMessage:@"你好,干啥" type:MessageModelTypeOther];
        textField.text = nil;
        return YES;
    }else if ([message isEqualToString:@"你忙啥呢"]){
        [self sendMessage:@"无聊" type:MessageModelTypeOther];
        textField.text = nil;
        return YES;
    }
    [self sendMessage:@"勿扰" type:MessageModelTypeOther];
    textField.text = nil;
    return YES;
}

- (void)sendMessage:(NSString *)messge type:(MessageModelType)type{
    MessageModel *model = [[MessageModel alloc] init];
    model.type = type;
    model.text = messge;
    //获取时间
    NSDate *date = [NSDate date];
    // 格式转换
    NSDateFormatter *matter = [[NSDateFormatter alloc] init];
    matter.dateFormat = @"HH:mm";
    model.time = [matter stringFromDate:date];
    //上一个消息ms
    MessageModel *lastMessage = [[self.messageArrayList lastObject] model];
    
    if ([model.time isEqualToString:lastMessage.time]) {
        model.hidenTime = YES;
    }
    MessageFrameModel *frameModel = [[MessageFrameModel alloc] init];
    frameModel.model = model;
    [self.messageArrayList addObject:frameModel];
    [self.tableView reloadData];
    
    NSIndexPath *path = [NSIndexPath indexPathForRow:self.messageArrayList.count - 1 inSection:0];
    [self.tableView scrollToRowAtIndexPath:path atScrollPosition:UITableViewScrollPositionBottom animated:YES];

    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
