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
    
    //load default.txt on screen inside a scroll view
    textFromFile = [NSString stringWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"default" ofType:@"txt"] encoding:NSUTF8StringEncoding error:nil];
    fileTitle.text = @"default.txt";
    fileTextView.text = textFromFile;
    fileTextView.scrollEnabled = TRUE;
    fileTextView.editable = FALSE;
    fileTextView.layer.borderWidth = 0.5f;
    fileTextView.layer.borderColor = [[UIColor grayColor] CGColor];
    
    [self reloadData];

    [super viewDidLoad];
    
}

//this method is called when a new file is selected
-(int)reloadData
{
    self.sentencesArray = [textFromFile componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@".!?"]];
    
    optimizedArray = [self optimizeArray:[NSMutableArray arrayWithArray:self.sentencesArray]];
    
    self.sortedArray = [self sort:optimizedArray];
    
    PickerArray = [[NSMutableArray alloc]init];
    
    for (int i = 0; i< [optimizedArray count]; i++) {
        PickerArray[i] = [NSNumber numberWithInt:i+1];
    }
    

    return (int)[optimizedArray count];
}

//method to remove invalid lines of length zero
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
    //number of values in picker will be equal to total number of lines in the file.
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


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"showSortedLines"]) {

        XLLLinesViewController *linesViewController = segue.destinationViewController;
        linesViewController.sentencesArray = self.sortedArray;
        linesViewController.numberOfLines = (self.numberOfLines < 1) ? 1 : self.numberOfLines;
    }
    if ([segue.identifier isEqualToString:@"showTextFiles"]) {
    
        UINavigationController *navigationController = segue.destinationViewController;
        XLLFilesViewController *filesViewController =[[navigationController viewControllers]objectAtIndex:0];

        filesViewController.myDelegate = self;
    }

}

- (IBAction)unwindToXLLViewController:(UIStoryboardSegue *)segue {
}

//method to shift elements in the heap based on lengths of the elements in descending order
-(NSMutableArray *) shift:(NSMutableArray *)arr startpoint: (NSInteger) start endpoint: (NSInteger) end
{
    NSInteger root = start;
    
    while((root * 2 + 1) <= end) {
        
        NSInteger child = root * 2 + 1;
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

//method to heapify the given array
-(NSMutableArray *) makeHeap:(NSMutableArray *)arr countt: (NSInteger) count
{
    NSMutableArray *arr3;
    NSInteger start = (count - 2) / 2;
    
    while(start >= 0) {
        arr3 = [self shift:arr startpoint:start endpoint:count - 1];
        start--;
    }
    
    return arr3;
}

//method that sorts the given array using heap sort approach
-(NSMutableArray *) sort:(NSMutableArray *)arr
{
    NSMutableArray *arr2;
    NSMutableArray *arr1 = [self makeHeap:arr countt:arr.count];
    NSInteger end = arr.count - 1;
    
    while(end > 0) {
        [arr1 exchangeObjectAtIndex:end withObjectAtIndex:0];
        arr2 = [self shift:arr1 startpoint:0 endpoint:end - 1];
        end--;
    }
    
    return arr2;
}

//called when a file is selected from the XLLFilesViewController's tableview
-(void) FilesViewControllerDismissed:(NSString *)fileNameToBeSent
{
    NSString *fileNameReceived = fileNameToBeSent;
    NSString *docsDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *filePath = [docsDirectory stringByAppendingPathComponent:fileNameReceived];
    textFromFile = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:NULL];
    fileTextView.text = textFromFile;
    fileTitle.text = fileNameReceived;
    [self reloadData];
    [picker reloadAllComponents];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
