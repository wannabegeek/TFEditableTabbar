//
//  TFEditingToolbar.h
//  EditableTabbar
//
//  Created by Tom Fewster on 07/12/2012.
//  Copyright (c) 2012 Tom Fewster. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TFEditingToolbar : UIToolbar

@property (readonly) UIBarButtonItem *deleteButtonItem;
@property (readonly) UIBarButtonItem *moveButtonItem;

@property (weak) id delegate;

- (id)initWithDelegate:(id)delegate;
@end
