//
//  XLLViewController.h
//  XLongestLines
//
//  Created by Rohit Kharat on 1/20/14.
//  Copyright (c) 2014 Rohit Kharat. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XLLViewController : UIViewController <UIPickerViewDelegate, UIPickerViewDataSource>

{
    UITextView *textView;
    NSString *textFromFile;
    NSMutableArray *PickerArray;
    NSMutableArray *optimizedArray;
    
    IBOutlet UITextView *fileTextView;
    
}

-(NSMutableArray*)optimizeArray: (NSMutableArray *) array;

@property (nonatomic, strong) NSArray *sentencesArray;
@property (nonatomic, strong) NSMutableArray *sortedArray;
@property (nonatomic) NSInteger numberOfLines;


@end
