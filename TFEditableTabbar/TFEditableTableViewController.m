//
//  TFEditableTableViewController.m
//  EditableTabbar
//
//  Created by Tom Fewster on 07/12/2012.
//  Copyright (c) 2012 Tom Fewster. All rights reserved.
//

#import "TFEditableTableViewController.h"
#import "UITabBarController+TabBarVisibility.h"
#import "TFEditingToolbar.h"

@interface TFEditableTableViewController ()
@property (strong) TFEditingToolbar *editingToolbar;
@property (strong) NSMutableArray *selectedIndexPaths;

@end

@implementation TFEditableTableViewController

@synthesize editingToolbar = _editingToolbar;
@synthesize selectedIndexPaths = _selectedIndexPaths;

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

    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)setEditing:(BOOL)editing animated:(BOOL)animated {
	[super setEditing:editing animated:animated];
	if (editing) {
		[self.tabBarController hideTabBarAnimated:NO];
		_editingToolbar = [[TFEditingToolbar alloc] initWithDelegate:self];
		_editingToolbar.translatesAutoresizingMaskIntoConstraints = NO;
		_editingToolbar.translucent = YES;
		[self.tabBarController.view addSubview:_editingToolbar];

		NSDictionary *views = NSDictionaryOfVariableBindings(_editingToolbar);
		[self.tabBarController.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_editingToolbar]|" options:kNilOptions metrics:nil views:views]];
		[self.tabBarController.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_editingToolbar(==44.0)]|" options:kNilOptions metrics:nil views:views]];

		_selectedIndexPaths = [NSMutableArray array];
		_editingToolbar.deleteButtonItem.enabled = NO;
		_editingToolbar.moveButtonItem.enabled = NO;

		_editingToolbar.delegate = self;

	} else {
		[self.tabBarController showTabBarAnimated:NO];
		[_editingToolbar removeFromSuperview];
		_editingToolbar = nil;
		_selectedIndexPaths = nil;
	}
}


- (void)deleteItems:(id)sender {
	if ([self respondsToSelector:@selector(tableViewController:updateIndexPaths:forOperation:)]) {
		[((id)self) tableViewController:self updateIndexPaths:[_selectedIndexPaths sortedArrayUsingComparator:^NSComparisonResult(NSIndexPath *obj1, NSIndexPath *obj2) {
			return [obj2 compare:obj1];
		}] forOperation:TFEditableTableViewOperationDelete];
		[_selectedIndexPaths removeAllObjects];
		_editingToolbar.deleteButtonItem.title = @"Delete";
		_editingToolbar.moveButtonItem.title = @"Move";
		_editingToolbar.deleteButtonItem.enabled = NO;
		_editingToolbar.moveButtonItem.enabled = NO;
		for (NSIndexPath *indexPath in [self.tableView indexPathsForSelectedRows]) {
			[self.tableView deselectRowAtIndexPath:indexPath animated:NO];
		}
	}
}

- (void)moveItems:(id)sender {
	if ([self respondsToSelector:@selector(tableViewController:updateIndexPaths:forOperation:)]) {
		[((id)self) tableViewController:self updateIndexPaths:[_selectedIndexPaths sortedArrayUsingComparator:^NSComparisonResult(NSIndexPath *obj1, NSIndexPath *obj2) {
			return [obj2 compare:obj1];
		}] forOperation:TFEditableTableViewOperationMove];
		[_selectedIndexPaths removeAllObjects];
		_editingToolbar.deleteButtonItem.title = @"Delete";
		_editingToolbar.moveButtonItem.title = @"Move";
		_editingToolbar.deleteButtonItem.enabled = NO;
		_editingToolbar.moveButtonItem.enabled = NO;
		for (NSIndexPath *indexPath in [self.tableView indexPathsForSelectedRows]) {
			[self.tableView deselectRowAtIndexPath:indexPath animated:NO];
		}
	}
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	if (self.editing) {
		[_selectedIndexPaths addObject:indexPath];
		NSUInteger count = [_selectedIndexPaths count];
		if (count == 0) {
			_editingToolbar.deleteButtonItem.title = @"Delete";
			_editingToolbar.moveButtonItem.title = @"Move";
			_editingToolbar.deleteButtonItem.enabled = NO;
			_editingToolbar.moveButtonItem.enabled = NO;
		} else {
			_editingToolbar.deleteButtonItem.title = [NSString stringWithFormat:@"Delete(%u)", count];
			_editingToolbar.moveButtonItem.title = [NSString stringWithFormat:@"Move(%u)", count];
			_editingToolbar.deleteButtonItem.enabled = YES;
			_editingToolbar.moveButtonItem.enabled = YES;
		}
	}
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
	if (self.editing) {
		[_selectedIndexPaths removeObject:indexPath];
		NSUInteger count = [_selectedIndexPaths count];
		if (count == 0) {
			_editingToolbar.deleteButtonItem.title = @"Delete";
			_editingToolbar.moveButtonItem.title = @"Move";
			_editingToolbar.deleteButtonItem.enabled = NO;
			_editingToolbar.moveButtonItem.enabled = NO;
		} else {
			_editingToolbar.deleteButtonItem.title = [NSString stringWithFormat:@"Delete(%u)", count];
			_editingToolbar.moveButtonItem.title = [NSString stringWithFormat:@"Move(%u)", count];
			_editingToolbar.deleteButtonItem.enabled = YES;
			_editingToolbar.moveButtonItem.enabled = YES;
		}
	}
}

@end
