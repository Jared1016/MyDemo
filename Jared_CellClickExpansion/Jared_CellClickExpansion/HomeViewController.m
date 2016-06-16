//
//  HomeViewController.m
//  Jared_CellClickExpansion
//
//  Created by Jared on 16/5/23.
//  Copyright © 2016年 Jared. All rights reserved.
//

#import "HomeViewController.h"
#import "HomeTableViewCell.h"
@interface HomeViewController ()<UITableViewDelegate,UITableViewDataSource>
//记录当前cell的状态
@property (nonatomic, assign)BOOL *isOpen;
//记录选择的cell的row
@property (nonatomic, assign)NSInteger selectedIndex;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor purpleColor];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"HomeTableViewCell" bundle:nil] forCellReuseIdentifier:@"HomeCell"];
    self.selectedIndex = -1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    HomeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HomeCell" forIndexPath:indexPath];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == self.selectedIndex) {
        if (self.isOpen) {
            self.selectedIndex = indexPath.row;
            return 70;
        }else{
            return 50;
        }
    }
    return 50;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == self.selectedIndex) {
        self.isOpen = !self.isOpen;
    }else{
        self.isOpen = YES;
    }
    self.selectedIndex = indexPath.row;
    [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:(UITableViewRowAnimationFade)];
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
