//
//  CollectionViewController.h
//  UICollectionViewTask(TM_Programmatically)
//
//  Created by Dmitriy Tarelkin on 4/7/18.
//  Copyright © 2018 Dmitriy Tarelkin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CollectionViewController : UICollectionViewController
@property (retain, nonatomic) NSMutableArray* taskDataSource;
- (void)addNewTask:(NSString*)taskName;
@end
