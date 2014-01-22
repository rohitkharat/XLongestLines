//
//  XLLViewController.h
//  XLongestLines
//
//  Created by Rohit Kharat on 1/20/14.
//  Copyright (c) 2014 Rohit Kharat. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XLLFilesViewController.h"

@interface XLLViewController : UIViewController <FilesDelegate, UIPickerViewDelegate, UIPickerViewDataSource>

{
    UITextView *textView;
    NSString *textFromFile;
    NSMutableArray *PickerArray;
    NSMutableArray *optimizedArray;
    
    IBOutlet UITextView *fileTextView;
    IBOutlet UIPickerView *picker;
    
}

-(NSMutableArray*)optimizeArray: (NSMutableArray *) array;

@property (nonatomic, strong) NSArray *sentencesArray;
@property (nonatomic, strong) NSMutableArray *sortedArray;
@property (nonatomic) NSInteger numberOfLines;


@end
