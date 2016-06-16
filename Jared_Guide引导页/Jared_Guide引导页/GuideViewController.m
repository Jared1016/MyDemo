//
//  GuideViewController.m
//  Jared_Guide引导页
//
//  Created by Jared on 16/6/12.
//  Copyright © 2016年 Jared. All rights reserved.
//

#import "GuideViewController.h"
#import "Masonry.h"
#import "AppDelegate.h"
#import "HomeViewController.h"
#import "Jared_PageControl.h"
#define SCREEN_BOUNDS [[UIScreen mainScreen] bounds]
#define SCREEN_HEIGHT [[UIScreen mainScreen] bounds].size.height
#define SCREEN_WIDTH [[UIScreen mainScreen] bounds].size.width
#define Image_Count 3
@interface GuideViewController ()<UIScrollViewDelegate>
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIPageControl *pageControl;
@property (nonatomic, strong) UIButton *btn;

@end

@implementation GuideViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //添加scrollView
    [self setUpScrollView];
}

- (void)setUpScrollView{
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    self.scrollView.contentSize = CGSizeMake(Image_Count * SCREEN_WIDTH, 0);
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.bounces = NO;
    self.scrollView.pagingEnabled = YES;
    self.scrollView.tag = 101;
    [self.view addSubview:self.scrollView];
    
    
    self.pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT-80, self.view.frame.size.width, 20)];
    self.pageControl.numberOfPages = Image_Count;
    self.pageControl.tag = 201;
//    [self.pageControl setImagePageStateNormal:[UIImage imageNamed:@"dian"]];
//    [self.pageControl setImagePageStateHighlighted:[UIImage imageNamed:@"dianbudian"]];
    [self.view addSubview:self.pageControl];
    
    
    CGFloat imageY = 0;
    CGFloat imageW = self.scrollView.frame.size.width;
    CGFloat imageH = self.scrollView.frame.size.height;
    for (int i = 0; i < Image_Count; i++) {
        UIImageView *imageView = [[UIImageView alloc] init];
        CGFloat imageX = i * imageW;
        imageView.frame = CGRectMake(imageX, imageY, imageW, imageH);
        NSString *name = [NSString stringWithFormat:@"yindao%d", i+1];
        imageView.image = [UIImage imageNamed:name];
        [self.scrollView addSubview:imageView];
    }
    self.scrollView.delegate = self;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    // 计算当前处于哪一页
    int current = self.scrollView.contentOffset.x/SCREEN_WIDTH;
    self.pageControl.currentPage = current;
    UIPageControl *page = (UIPageControl *)[self.view viewWithTag:201];
    if (page.currentPage == Image_Count - 1) {
        [self scrollViewdisappear];
    }else{
        if (_btn) {
            [_btn removeFromSuperview];
            _btn = nil;
        }
        page.hidden = NO;
    }
}

- (void)scrollViewdisappear{
    UIPageControl *page = (UIPageControl *)[self.view viewWithTag:201];
    page.hidden = YES;
    if (_btn) {
        return;
    }
    _btn = [UIButton buttonWithType:(UIButtonTypeSystem)];
    [_btn setBackgroundImage:[UIImage imageNamed:@"kaishi"] forState:(UIControlStateNormal)];
    [_btn setBackgroundImage:[UIImage imageNamed:@"kaishixiaoguo"] forState:(UIControlStateHighlighted)];
    [_btn addTarget:self action:@selector(btnAction) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:_btn];
    [_btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.bottom.equalTo(self.view.mas_bottom).offset(-30);
        make.width.equalTo(@150);
        make.height.equalTo(@50);
    }];
}

- (void)btnAction{
    HomeViewController *hVC = [[HomeViewController alloc] initWithNibName:@"HomeViewController" bundle:nil];
    AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
    delegate.window.rootViewController = hVC;
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
