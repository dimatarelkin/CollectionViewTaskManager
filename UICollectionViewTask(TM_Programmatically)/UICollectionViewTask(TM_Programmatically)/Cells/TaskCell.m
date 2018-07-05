//
//  TaskCell.m
//  UICollectionViewTask(TM_Programmatically)
//
//  Created by Dmitriy Tarelkin on 4/7/18.
//  Copyright © 2018 Dmitriy Tarelkin. All rights reserved.
//

#import "TaskCell.h"

@interface TaskCell()
@property (assign, nonatomic) BOOL isDone;
@end

@implementation TaskCell



- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupViews];
    }
    return self;
}

- (UILabel *)taskLabel {
    if (!_taskLabel) {
        _taskLabel = [[UILabel alloc] init];
        _taskLabel.translatesAutoresizingMaskIntoConstraints = NO;
        _taskLabel.font = [UIFont systemFontOfSize:14.0 weight:UIFontWeightRegular];
        _taskLabel.text = @"Sample";
        _taskLabel.numberOfLines = 0;
        _taskLabel.textColor = UIColor.blackColor;
    }
    return _taskLabel;
}

- (UIButton *)doneButton {
    if (!_doneButton) {
        _doneButton = [[UIButton alloc] init];
        _doneButton.translatesAutoresizingMaskIntoConstraints = NO;
        _doneButton.backgroundColor = UIColor.clearColor;
        _doneButton.layer.cornerRadius = 15;
        [_doneButton setTitle:@"Done" forState:UIControlStateNormal];
        [_doneButton setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
        [_doneButton addTarget:self action:@selector(doneActionHandler:) forControlEvents:UIControlEventTouchUpInside];
        _isDone = NO;
    }
    return _doneButton;
}

- (void)doneActionHandler: (UIButton*)sender {
    if (!self.isDone) {
        [UIView animateWithDuration:0.5 animations:^{
            self.backgroundColor = UIColor.greenColor;
            [sender setTitle:@"✔️" forState:UIControlStateNormal];
        }];
        self.isDone = !self.isDone;

    } else {
        [UIView animateWithDuration:0.5 animations:^{
            self.backgroundColor = UIColor.whiteColor;
            [sender setTitle:@"Done" forState:UIControlStateNormal];
        }];
        self.isDone = !self.isDone;
    }
}


- (void)setupViews {
    self.backgroundColor = UIColor.whiteColor;
    self.layer.cornerRadius = 15;
    self.layer.borderWidth = 1;
    self.layer.borderColor = UIColor.blackColor.CGColor;
    
    //label
    [self addSubview:self.taskLabel];

    //button
    [self addSubview:self.doneButton];
    
    CGFloat margin = 20;
    [NSLayoutConstraint activateConstraints:
                @[
                [self.taskLabel.leadingAnchor constraintEqualToAnchor:self.leadingAnchor constant:margin],
                [self.taskLabel.topAnchor constraintEqualToAnchor:self.topAnchor constant:margin],
                [self.taskLabel.bottomAnchor constraintEqualToAnchor:self.bottomAnchor constant:- margin],
                [self.doneButton.leadingAnchor constraintEqualToAnchor:self.taskLabel.trailingAnchor constant:margin],
                [self.doneButton.topAnchor constraintEqualToAnchor:self.topAnchor constant:1],
                [self.doneButton.bottomAnchor constraintEqualToAnchor:self.bottomAnchor constant:-1],
                [self.doneButton.trailingAnchor constraintEqualToAnchor:self.trailingAnchor constant:-1],
                [self.doneButton.widthAnchor constraintEqualToConstant:60]
                                                                            ]];
    
}


@end
