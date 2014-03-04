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

    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory , NSUserDomainMask, YES);
    NSString* documentsDir = [paths objectAtIndex:0];

    self.filesList = [[NSMutableArray alloc]init];
    self.filesList = [NSMutableArray arrayWithArray:[self getFileAtPath:documentsDir]];
}

//gets all files at given path
-(NSArray *)getFileAtPath:(NSString *)path
{
    NSArray *filesArray = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:path error:NULL];
    return filesArray;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.filesList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    cell.textLabel.text = [self.filesList objectAtIndex:indexPath.row];
    
    return cell;
}

//method for cancel button
-(IBAction)dismissModal:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

//send the selected file name back to XLLViewController and dismiss this view controller
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *selectedCell = [tableView cellForRowAtIndexPath:indexPath];
    self.selectedFile = selectedCell.textLabel.text;
    
    if ([self.myDelegate respondsToSelector:@selector(FilesViewControllerDismissed:)]) {
        [self.myDelegate FilesViewControllerDismissed:self.selectedFile];
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
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
