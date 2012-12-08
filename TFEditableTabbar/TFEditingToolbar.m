//
//  TFEditingToolbar.m
//  EditableTabbar
//
//  Created by Tom Fewster on 07/12/2012.
//  Copyright (c) 2012 Tom Fewster. All rights reserved.
//

#import "TFEditingToolbar.h"

@interface TFEditingToolbar ()
- (void)postInitialise;
@end

@implementation TFEditingToolbar

@synthesize deleteButtonItem = _deleteButtonItem;
@synthesize moveButtonItem = _moveButtonItem;
@synthesize delegate = _toolbarDelegate;

- (id)initWithDelegate:(id)delegate {
    self = [super init];
    if (self) {
		_toolbarDelegate = delegate;
        [self postInitialise];
    }
    return self;
}

- (void)postInitialise {
	_deleteButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Delete" style:UIBarButtonItemStyleBordered target:_toolbarDelegate action:@selector(deleteItems:)];
	_deleteButtonItem.tintColor = [UIColor redColor];
	_moveButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Move" style:UIBarButtonItemStyleBordered target:_toolbarDelegate action:@selector(moveItems:)];

	self.items = @[_deleteButtonItem, [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil], _moveButtonItem];
}

- (void)layoutSubviews {
	if (self.superview) {
		CGFloat width = self.superview.frame.size.width;
		if (UIDeviceOrientationIsLandscape([UIApplication sharedApplication].statusBarOrientation)) {
			width = self.superview.frame.size.height;
		}
		_deleteButtonItem.width = width/2.0 - 12;
		_moveButtonItem.width = width/2.0 - 12;
	}
}


@end
