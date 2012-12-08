//
//  TFDemoTableViewController.m
//  EditableTabbar
//
//  Created by Tom Fewster on 07/12/2012.
//  Copyright (c) 2012 Tom Fewster. All rights reserved.
//

#import "TFDemoTableViewController.h"

@interface TFDemoTableViewController ()
@property (strong) NSMutableArray *values;
@end

@implementation TFDemoTableViewController

@synthesize values = _values;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.

	_values = [@[@"Table Cell 1", @"Table Cell 2", @"Table Cell 3", @"Table Cell 4", @"Table Cell 5", @"Table Cell 6", @"Table Cell 7", @"Table Cell 8", @"Table Cell 9", @"Table Cell 10"] mutableCopy];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)tableViewController:(TFEditableTableViewController *)tableViewController updateIndexPaths:(NSArray *)indexPaths forOperation:(TFEditableTableViewOperation)operation {
	if (operation == TFEditableTableViewOperationDelete) {
		for (NSIndexPath *indexPath in indexPaths) {
			[_values removeObjectAtIndex:indexPath.row];
		}
		[self.tableView deleteRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationFade];
	}
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
    return [_values count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];

    // Configure the cell...
	cell.textLabel.text = [_values objectAtIndex:indexPath.row];

    return cell;
}

// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}


@end
