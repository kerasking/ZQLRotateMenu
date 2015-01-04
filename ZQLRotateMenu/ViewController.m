//
//  ViewController.m
//  ZQLRotateMenu
//
//  Created by zangqilong on 15/1/4.
//  Copyright (c) 2015年 zangqilong. All rights reserved.
//

#import "ViewController.h"
#import "ZQLRotateView.h"

@interface ViewController ()
{
    ZQLRotateView *rotateView;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSArray *arr1 = @[@"菜单1",@"菜单2",@"菜单3",@"菜单4",@"菜单5",@"菜单6",@"菜单7",@"菜单8",@"菜单9"];
    
    rotateView = [[ZQLRotateView alloc] initWithFrame:self.view.bounds WithTitleArrays:arr1];
    
    [self.view addSubview:rotateView];
    
    [self.view sendSubviewToBack:rotateView];
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)startAnimation:(id)sender
{
    [rotateView startAnimation];
}

- (IBAction)endAnimation:(id)sender
{
    [rotateView hideAnimation];
}

@end
