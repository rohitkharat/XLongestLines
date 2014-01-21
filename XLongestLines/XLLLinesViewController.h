//
//  XLLLinesViewController.h
//  XLongestLines
//
//  Created by Rohit Kharat on 1/21/14.
//  Copyright (c) 2014 Rohit Kharat. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XLLLinesViewController : UITableViewController <UITableViewDelegate>

@property (nonatomic, strong) NSArray *sentencesArray;
@property (nonatomic) NSInteger numberOfLines;

@end
