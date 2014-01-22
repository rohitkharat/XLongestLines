//
//  XLLViewController.m
//  XLongestLines
//
//  Created by Rohit Kharat on 1/20/14.
//  Copyright (c) 2014 Rohit Kharat. All rights reserved.
//

#import "XLLViewController.h"
#import "XLLLinesViewController.h"


@interface XLLViewController ()

@end

@implementation XLLViewController

@synthesize sentencesArray;
@synthesize sortedArray;
@synthesize numberOfLines;

- (void)viewDidLoad
{
    self.navigationItem.title = @"X - Longest Lines App";
    textFromFile = [NSString stringWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"test" ofType:@"txt"] encoding:NSUTF8StringEncoding error:nil];
    
    fileTextView.text = textFromFile;
    fileTextView.scrollEnabled = TRUE;
    fileTextView.editable = FALSE;
    fileTextView.layer.borderWidth = 0.5f;
    fileTextView.layer.borderColor = [[UIColor grayColor] CGColor];
    
    [self reloadData];

    [super viewDidLoad];
    
}

-(int)reloadData
{
    self.sentencesArray = [textFromFile componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@".!?"]];
    
    optimizedArray = [self optimizeArray:[NSMutableArray arrayWithArray:self.sentencesArray]];
    
    self.sortedArray = [self heap_sort:optimizedArray];
    
    PickerArray = [[NSMutableArray alloc]init];
    
    for (int i = 0; i< [optimizedArray count]; i++) {
        PickerArray[i] = [NSNumber numberWithInt:i+1];
    }
    

    return [optimizedArray count];
}

-(NSMutableArray*)optimizeArray: (NSMutableArray *) array
{
    NSMutableArray *optimized = [[NSMutableArray alloc]init];
    for (NSString *string in array) {
        if (string.length > 0) {
            NSString *trimmedLine = [string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
            [optimized addObject:trimmedLine];

        }
    }
    
    return optimized;
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return [PickerArray count];
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [PickerArray[row] stringValue];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    self.numberOfLines = [PickerArray[row] integerValue];
}

//- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
//{
//    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(20.0f, 0.0f, 300.0f, 60.0f)]; //x and width are mutually correlated
//    label.textAlignment = NSTextAlignmentCenter;
//    label.text = [PickerArray objectAtIndex:row];
//    return label;
//
//}
//

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"showSortedLines"]) {

        XLLLinesViewController *linesViewController = segue.destinationViewController;
        linesViewController.sentencesArray = self.sortedArray;
        linesViewController.numberOfLines = (self.numberOfLines < 1) ? 1 : self.numberOfLines;
        //linesViewController.numberOfLines = self.numberOfLines;
    }
    if ([segue.identifier isEqualToString:@"showTextFiles"]) {
    
        UINavigationController *navigationController = segue.destinationViewController;
        XLLFilesViewController *filesViewController =[[navigationController viewControllers]objectAtIndex:0];

        filesViewController.myDelegate = self;
    }

}

-(NSMutableArray *) sift_down:(NSMutableArray *)arr startt: (NSInteger) start endd: (NSInteger) end
{
//    NSLog(@"siftdown");
    NSInteger root = start;
    
    while((root * 2 + 1) <= end) {
//        NSLog(@"while loop in siftdown");

        NSInteger child = root * 2 + 1;
//        NSLog(@"[arr objectAtIndex:child] integerValue] is %ld", (long)[[arr objectAtIndex:child] integerValue]);
        if(child + 1 <= end && [[arr objectAtIndex:child] length] > [[arr objectAtIndex:child + 1] length])
            child++;
        
        if([[arr objectAtIndex:root] length] > [[arr objectAtIndex:child] length]) {
            [arr exchangeObjectAtIndex:root withObjectAtIndex:child];
            root = child;
        }
        else
            return arr;
    }
    
    return arr;
}

-(NSMutableArray *) heapify:(NSMutableArray *)arr countt: (NSInteger) count
{
    NSMutableArray *arr3;

    NSInteger start = (count - 2) / 2;
    
    while(start >= 0) {
        arr3 = [self sift_down:arr startt:start endd:count - 1];
        start--;
    }
    
    return arr3;
}

-(NSMutableArray *) heap_sort:(NSMutableArray *)arr
{
    NSLog(@"heapsort");

    NSMutableArray *arr2;
    NSMutableArray *arr1 = [self heapify:arr countt:arr.count];
    NSInteger end = arr.count - 1;
    
    while(end > 0) {
        [arr1 exchangeObjectAtIndex:end withObjectAtIndex:0];
       arr2 = [self sift_down:arr1 startt:0 endd:end - 1];
        end--;
    }
    
    return arr2;
}

-(void) FilesViewControllerDismissed:(NSString *)fileNameToBeSent
{
    NSString *fileNameReceived = fileNameToBeSent;
    NSLog(@"file name received: %@", fileNameReceived);
    NSString *docsDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *filePath = [docsDirectory stringByAppendingPathComponent:fileNameReceived];
    NSLog(@"file path: %@", filePath);
    textFromFile = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:NULL];
    fileTextView.text = textFromFile;
    [self reloadData];
    [picker reloadAllComponents];
    [picker selectRow:[PickerArray count]/2 inComponent:0 animated:YES];


}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//code to be added:
//if last character in file is . or ? or ! then only reduce sentence count by 1.
//change heap sort code
//remove logs
@end
