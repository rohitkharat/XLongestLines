//
//  XLLAppDelegate.h
//  XLongestLines
//
//  Created by Rohit Kharat on 1/20/14.
//  Copyright (c) 2014 Rohit Kharat. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XLLAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

-(void)copyFolderToDocumentsDirectory: (NSString *)fileName;

@end
