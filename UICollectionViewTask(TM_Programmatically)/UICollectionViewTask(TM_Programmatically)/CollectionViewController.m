//
//  CollectionViewController.m
//  UICollectionViewTask(TM_Programmatically)
//
//  Created by Dmitriy Tarelkin on 4/7/18.
//  Copyright © 2018 Dmitriy Tarelkin. All rights reserved.
//

#import "CollectionViewController.h"
#import "TaskCell.h"
#import "TaskHeaderCell.h"

@interface CollectionViewController () <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>


@end



@implementation CollectionViewController


static NSString * const reuseIdentifier = @"Cell";
static NSString * const reuseHeaderdentifier = @"HeaderCell";



- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"To-Do";
    self.collectionView.backgroundColor = UIColor.whiteColor;
    self.collectionView.alwaysBounceVertical = YES;
    
    // Register cell classes
    [self.collectionView registerClass:[TaskCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
    //register classes for HeaderCell
    [self.collectionView registerClass:[TaskHeaderCell class] forSupplementaryViewOfKind: UICollectionElementKindSectionHeader withReuseIdentifier:reuseHeaderdentifier];
    
    _taskDataSource = [NSMutableArray array];
    
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    
    
    //addGesture to deleteItems
    UISwipeGestureRecognizer * swipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeGestureHandler:)];
    swipe.direction = UISwipeGestureRecognizerDirectionLeft;
    [self.collectionView addGestureRecognizer:swipe];
}




#pragma mark - Actions

- (void)addNewTask:(NSString*)taskName {
    [self.taskDataSource addObject:taskName];
    [self.collectionView reloadData];
}

- (void)swipeGestureHandler:(UISwipeGestureRecognizer*)swipe {
    CGPoint point = [swipe locationInView:self.collectionView];
    NSIndexPath * indexPath = [self.collectionView indexPathForItemAtPoint:point];
    NSMutableArray* newData = [NSMutableArray arrayWithArray:self.taskDataSource];
    if (swipe.state == UIGestureRecognizerStateEnded) {
        [newData removeObjectAtIndex:indexPath.item];
        [self.collectionView reloadData];
    }
    self.taskDataSource = [NSMutableArray arrayWithArray:newData];
}




#pragma mark <UICollectionViewDataSource>

//SECTION
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    NSLog(@"numberOfSectionsInCollectionView");
    return 1;
}

//CELL
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    NSLog(@"numberOfItemsInSection");
    return [self.taskDataSource count];
}


#warning Trouble with reusing cells
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    TaskCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    cell.taskLabel.text = [NSString stringWithFormat:@"%@",self.taskDataSource[indexPath.item]];
    
    
    if (!cell) {
        cell = [[TaskCell alloc] init];
        NSLog(@"New cell created");
    }else {
        NSLog(@"cell reused %@",cell.taskLabel.text);
    }
    
    return cell;
}



//HEADER
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    TaskHeaderCell * headerCell = [collectionView dequeueReusableSupplementaryViewOfKind:kind
                                                                     withReuseIdentifier:reuseHeaderdentifier
                                                                            forIndexPath:indexPath];
    headerCell.controller = self;
    return headerCell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    
    return CGSizeMake(self.view.frame.size.width, 150);
}







#pragma mark <UICollectionViewDelegateFlowLayout>

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(CGRectGetWidth(collectionView.frame) - 15, 80 - 10);
}


- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    //    UIEdgeInsets insets = {top, left, bottom, right};
    return UIEdgeInsetsMake(10, 5, 5, 5);
}







#pragma mark <UICollectionViewDelegate>

- (BOOL)collectionView:(UICollectionView *)collectionView canMoveItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
- (void)collectionView:(UICollectionView *)collectionView moveItemAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath {
    NSString *item = self.taskDataSource[sourceIndexPath.item];
    [self.taskDataSource removeObjectAtIndex:sourceIndexPath.item];
    [self.taskDataSource insertObject:item atIndex:destinationIndexPath.item];
}




@end
