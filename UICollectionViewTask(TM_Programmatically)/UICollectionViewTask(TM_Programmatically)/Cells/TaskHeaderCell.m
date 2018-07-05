//
//  TaskHeaderCell.m
//  UICollectionViewTask(TM_Programmatically)
//
//  Created by Dmitriy Tarelkin on 4/7/18.
//  Copyright © 2018 Dmitriy Tarelkin. All rights reserved.
//

#import "TaskHeaderCell.h"

@interface TaskHeaderCell() <UITextFieldDelegate>
@end


@implementation TaskHeaderCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupViews];
    }
    return self;
}

- (UITextField *)taskNameTextField {
    if (!_taskNameTextField) {
        _taskNameTextField = [[UITextField alloc] init];
        _taskNameTextField.translatesAutoresizingMaskIntoConstraints = NO;
        _taskNameTextField.font = [UIFont systemFontOfSize:14.0 weight:UIFontWeightRegular];
        _taskNameTextField.textColor = UIColor.blackColor;
        _taskNameTextField.placeholder = @"Enter task name...";
        _taskNameTextField.delegate = self;
        _taskNameTextField.keyboardType = UIKeyboardTypeDefault;
    }
    
    return _taskNameTextField;
}

- (UIButton *)addTaskButton {
    if (!_addTaskButton) {
        _addTaskButton = [UIButton buttonWithType:UIButtonTypeSystem];
        _addTaskButton.layer.cornerRadius = 15;
        _addTaskButton.translatesAutoresizingMaskIntoConstraints = NO;
        [_addTaskButton setTitle:@"+ Add New Task" forState:UIControlStateNormal];
        [_addTaskButton addTarget:self action:@selector(addTaskActionHandler:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _addTaskButton;
}


- (void)addTaskActionHandler:(UIButton*)sender {
    [self.controller addNewTask:self.taskNameTextField.text];
    self.taskNameTextField.text = @"";
}


- (void)setupViews {
    self.backgroundColor = UIColor.whiteColor;
    self.layer.borderColor = UIColor.blackColor.CGColor;
    
    
    //UItextField
    
    self.taskNameTextField.borderStyle = UITextBorderStyleRoundedRect;
    self.taskNameTextField.clearsOnBeginEditing = YES;
    [self addSubview:self.taskNameTextField];
    
    
    //button
    [self addSubview:self.addTaskButton];
    
    CGFloat margin = 10;
    [NSLayoutConstraint activateConstraints:
     @[
       [self.taskNameTextField.leadingAnchor constraintEqualToAnchor:self.leadingAnchor constant:margin],
       [self.taskNameTextField.topAnchor constraintEqualToAnchor:self.topAnchor constant:margin],
       [self.taskNameTextField.bottomAnchor constraintEqualToAnchor:self.addTaskButton.bottomAnchor constant:-margin*6],
       [self.taskNameTextField.trailingAnchor constraintEqualToAnchor:self.trailingAnchor constant:-margin],
       [self.addTaskButton.bottomAnchor constraintEqualToAnchor:self.bottomAnchor constant:-margin],
       [self.addTaskButton.trailingAnchor constraintEqualToAnchor:self.trailingAnchor constant:-margin],
       [self.addTaskButton.widthAnchor constraintEqualToAnchor:self.taskNameTextField.widthAnchor multiplier:1]
       ]];
    
}

#pragma mark - <UITextFieldDelegate>

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self.taskNameTextField resignFirstResponder];
    [self.controller addNewTask:self.taskNameTextField.text];
    self.taskNameTextField.text = @"";
    NSLog(@"enter");
    
    return YES;
}



@end
