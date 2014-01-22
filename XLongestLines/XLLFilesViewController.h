//
//  XLLFilesViewController.h
//  XLongestLines
//
//  Created by Rohit Kharat on 1/21/14.
//  Copyright (c) 2014 Rohit Kharat. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "XLLViewController.h"

@protocol FilesDelegate <NSObject>
-(void) FilesViewControllerDismissed:(NSString *)fileNameToBeSent;
@end

@interface XLLFilesViewController : UITableViewController <UITableViewDataSource, UITableViewDelegate>
{
//    id myDelegate;
}

-(IBAction)dismissModal:(id)sender;

@property (nonatomic, strong) NSMutableArray *filesList;
//@property (nonatomic, strong) XLLViewController *xllViewController;
@property (nonatomic, strong) NSString *selectedFile;
@property (nonatomic, assign) id<FilesDelegate> myDelegate;
@end
