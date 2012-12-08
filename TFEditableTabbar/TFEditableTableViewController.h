//
//  TFEditableTableViewController.h
//  EditableTabbar
//
//  Created by Tom Fewster on 07/12/2012.
//  Copyright (c) 2012 Tom Fewster. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
	TFEditableTableViewOperationDelete,
	TFEditableTableViewOperationMove
} TFEditableTableViewOperation;

@class TFEditableTableViewController;

@protocol TFEditableTableViewDelegate <NSObject>
- (void)tableViewController:(TFEditableTableViewController *)tableViewController updateIndexPaths:(NSArray *)indexPaths forOperation:(TFEditableTableViewOperation)operation;
@end

@interface TFEditableTableViewController : UITableViewController

@end
