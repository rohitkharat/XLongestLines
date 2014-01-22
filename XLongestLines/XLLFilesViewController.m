//
//  XLLFilesViewController.m
//  XLongestLines
//
//  Created by Rohit Kharat on 1/21/14.
//  Copyright (c) 2014 Rohit Kharat. All rights reserved.
//

#import "XLLFilesViewController.h"
#include "XLLViewController.h"

@interface XLLFilesViewController ()

@end

@implementation XLLFilesViewController

@synthesize filesList;
//@synthesize xllViewController;
@synthesize selectedFile;
@synthesize myDelegate;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    NSFileManager* fileManager = [NSFileManager defaultManager];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory , NSUserDomainMask, YES);
    NSString* documentsDir = [paths objectAtIndex:0];

    self.filesList = [[NSMutableArray alloc]init];
    self.filesList = [NSMutableArray arrayWithArray:[self listFileAtPath:documentsDir]];
//    self.xllViewController = [[XLLViewController alloc]init];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
//    NSString *documentsPath= [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
//    NSError *error;
//    NSArray* files= [[NSFileManager defaultManager] contentsOfDirectoryAtPath:documentsPath error:&error];
//    NSRange range;
//    
//    for (NSString* file in files) {
//        range = [file rangeOfString:@".txt"
//                            options:NSCaseInsensitiveSearch];
//        if (range.location!= NSNotFound) {
//            [self.filesList addObject:file];
//        }
//    }
//    
//    NSLog(@"files list %@", files);
}

-(NSArray *)listFileAtPath:(NSString *)path
{
    //-----> LIST ALL FILES <-----//
    NSLog(@"LISTING ALL FILES FOUND");
    
    int count;
    
    NSArray *directoryContent = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:path error:NULL];
    for (count = 0; count < (int)[directoryContent count]; count++)
    {
        NSLog(@"File %d: %@", (count + 1), [directoryContent objectAtIndex:count]);
    }
    return directoryContent;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.filesList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    cell.textLabel.text = [self.filesList objectAtIndex:indexPath.row];
    
    return cell;
}

-(IBAction)dismissModal:(id)sender
{
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //get file name and path and send it to other view controller
    UITableViewCell *selectedCell = [tableView cellForRowAtIndexPath:indexPath];
    self.selectedFile = selectedCell.textLabel.text;
    
    if ([self.myDelegate respondsToSelector:@selector(FilesViewControllerDismissed:)]) {
        [self.myDelegate FilesViewControllerDismissed:self.selectedFile];
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
  //  [self performSegueWithIdentifier:@"unwind" sender:self];

}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

 */

@end
