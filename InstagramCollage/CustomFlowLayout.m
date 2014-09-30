//
//  CustomFlowLayout.m
//  InstagramCollage
//
//  Created by Anton on 8/18/14.
//  Copyright (c) 2014 áSoft. All rights reserved.
//

#import "CustomFlowLayout.h"

@implementation CustomFlowLayout


- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
 {
     return [super layoutAttributesForElementsInRect:rect];
 }
 
 - (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
 {
 // configure CellAttributes
     UICollectionViewLayoutAttributes *cellAttributes = [[UICollectionViewLayoutAttributes alloc] init];
     cellAttributes = [super layoutAttributesForItemAtIndexPath:indexPath];
 
 // random position
 int xRand = arc4random() % 320;
 int yRand = arc4random() % 460;
 cellAttributes.frame = CGRectMake(xRand, yRand, 150, 170);
     NSLog(@"TESTSTSTSTS");
 
 return cellAttributes;
 }

// indicate that we want to redraw as we scroll
- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
    return YES;
}





@end
