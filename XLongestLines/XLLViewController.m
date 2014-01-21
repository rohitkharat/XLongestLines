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
    textFromFile = [NSString stringWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"test" ofType:@"txt"] encoding:NSUTF8StringEncoding error:nil];
    
    fileTextView.text = textFromFile;
    fileTextView.scrollEnabled = TRUE;
    fileTextView.editable = FALSE;
    fileTextView.layer.borderWidth = 0.5f;
    fileTextView.layer.borderColor = [[UIColor grayColor] CGColor];
    
    self.sentencesArray = [textFromFile componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@".!?"]];

 //   NSLog(@"no. of sentences in file = %lu", (unsigned long)[self.sentencesArray count]);
 //   NSLog(@"array: %@" , self.sentencesArray);
    
    optimizedArray = [self optimizeArray:[NSMutableArray arrayWithArray:self.sentencesArray]];

    NSLog(@"optimized array: %@", optimizedArray);

   // self.sortedArray = [self heap_sort:[NSMutableArray arrayWithArray:self.sentencesArray]];
    self.sortedArray = [self heap_sort:optimizedArray];

    NSLog(@"sorted array %@", self.sortedArray);
    PickerArray = [[NSMutableArray alloc]init];
    
    for (int i = 0; i< [optimizedArray count]; i++) {
        PickerArray[i] = [NSNumber numberWithInt:i+1];
    }
    
//    [self verfiySorted:sortedArray];
    [super viewDidLoad];
    
}

-(NSMutableArray*)optimizeArray: (NSMutableArray *) array
{
    NSMutableArray *optimized = [[NSMutableArray alloc]init];
    for (NSString *string in array) {
        if (string.length > 0) {
            NSLog(@"str length > 0");
            NSString *trimmedLine = [string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
            [optimized addObject:trimmedLine];

        }
    }
    
    return optimized;
}

//- (IBAction)openExistingDocument:(id)sender {
//    NSOpenPanel* panel = [NSOpenPanel openPanel];
//    
//    // This method displays the panel and returns immediately.
//    // The completion handler is called when the user selects an
//    // item or cancels the panel.
//    [panel beginWithCompletionHandler:^(NSInteger result){
//        if (result == NSFileHandlingPanelOKButton) {
//            NSURL*  theDoc = [[panel URLs] objectAtIndex:0];
//            
//            // Open  the document.
//        }
//        
//    }];
//}
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

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"showSortedLines"]) {

        XLLLinesViewController *linesViewController = segue.destinationViewController;
        linesViewController.sentencesArray = self.sortedArray;
        linesViewController.numberOfLines = (self.numberOfLines < 1) ? 1 : self.numberOfLines;
        //linesViewController.numberOfLines = self.numberOfLines;
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
    NSLog(@"heapify");

    NSInteger start = (count - 2) / 2;
    
    while(start >= 0) {
        arr3 = [self sift_down:arr startt:start endd:count - 1];
        start--;
    }
    
    return arr3;
}

-(NSMutableArray *) heap_sort:(NSMutableArray *)arr
{
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
