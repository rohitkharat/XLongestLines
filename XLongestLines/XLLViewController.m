//
//  XLLViewController.m
//  XLongestLines
//
//  Created by Rohit Kharat on 1/20/14.
//  Copyright (c) 2014 Rohit Kharat. All rights reserved.
//

#import "XLLViewController.h"

@interface XLLViewController ()

@end

@implementation XLLViewController

- (void)viewDidLoad
{
    textView = [[UITextView alloc]initWithFrame:CGRectMake(0, 0, 320, 460)];
    textView.text = [NSString stringWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"test" ofType:@"txt"] encoding:NSUTF8StringEncoding error:nil];
    [self.view addSubview:textView];

    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
