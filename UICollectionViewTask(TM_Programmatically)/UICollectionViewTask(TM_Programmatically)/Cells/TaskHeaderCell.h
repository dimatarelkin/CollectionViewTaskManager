//
//  TaskHeaderCell.h
//  UICollectionViewTask(TM_Programmatically)
//
//  Created by Dmitriy Tarelkin on 4/7/18.
//  Copyright © 2018 Dmitriy Tarelkin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CollectionViewController.h"


@interface TaskHeaderCell : UICollectionViewCell
@property (nonatomic) UITextField* taskNameTextField;
@property (nonatomic) UIButton* addTaskButton;
@property (weak,nonatomic) CollectionViewController* controller;
@end
