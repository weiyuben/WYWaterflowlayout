//
//  WYWaterflowlayout.m
//  WYWaterflow1
//
//  Created by weibenyu on 16/6/21.
//  Copyright © 2016年 weibenyu. All rights reserved.
//

#import "WYWaterflowlayout.h"

@interface WYWaterflowlayout()
/**属性数组*/
@property (nonatomic ,strong)NSMutableArray *attrsArr;
/**column heights*/
@property (nonatomic ,strong)NSMutableArray *columnHeights;

- (CGFloat)rowMargin;
- (CGFloat)columnMargin;
- (NSInteger)columnCount;
- (UIEdgeInsets)edgeInsets;
@end

static int const DefaultColumnCount = 3;
static const CGFloat DefaultColumnMargin = 10.0;
static const CGFloat DefaultRowMargin = 10.0;
static const UIEdgeInsets DefaultEdgeInsets = (UIEdgeInsets){10, 10, 10, 10};




@implementation WYWaterflowlayout

- (CGFloat)rowMargin {
    if ([self.delegate respondsToSelector:@selector(rowMarginInWaterflowLayout:)]) {
        return [self.delegate rowMarginInWaterflowLayout:self];
    } else {
        return DefaultRowMargin;
    }
    
}
- (CGFloat)columnMargin {
    if ([self.delegate respondsToSelector:@selector(columnMarginInWaterflowLayout:)]) {
        return  [self.delegate columnMarginInWaterflowLayout:self];
    } else {
        return  DefaultColumnMargin;
    }
}
- (NSInteger)columnCount {
    if ([self.delegate respondsToSelector:@selector(columnCountInWaterflowLayout:)]) {
        return [self.delegate columnCountInWaterflowLayout:self];
    } else {
        return DefaultColumnCount;
    }
}
- (UIEdgeInsets)edgeInsets{
    if ([self.delegate respondsToSelector:@selector(edgeInsetsInWaterflowLayout:)]) {
        return [self.delegate edgeInsetsInWaterflowLayout:self];
    } else {
        return DefaultEdgeInsets;
    }
}


- (NSMutableArray *)attrsArr {
    if (!_attrsArr){
        _attrsArr = [NSMutableArray array];
    }
    return _attrsArr;
}


- (NSMutableArray *)columnHeights {
    if (!_columnHeights){
        _columnHeights = [NSMutableArray array];
    }
    return _columnHeights;
}
-(void)prepareLayout
{
    [super prepareLayout];
    
    [self.columnHeights removeAllObjects];
    for (int i=0; i < DefaultColumnCount; i++) {
        [self.columnHeights addObject:@(self.edgeInsets.top)];
    }
    
    
    [self.attrsArr removeAllObjects];
    NSInteger count = [self.collectionView numberOfItemsInSection:0];
    
    for (int i=0; i<count; i++) {
        
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:0];
        
        UICollectionViewLayoutAttributes *attr = [self layoutAttributesForItemAtIndexPath:indexPath];
        
        
        [self.attrsArr addObject:attr];

    }
}

- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect
{
    return self.attrsArr;
}


- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    UICollectionViewLayoutAttributes *attr = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    
    CGFloat collectionViewWidth = self.collectionView.bounds.size.width;
    
    CGFloat w = (collectionViewWidth - (self.columnCount -1)*self.columnMargin - self.edgeInsets.left - self.edgeInsets.right)/self.columnCount;
    
    NSInteger destColumn = 0;
    CGFloat minHeight = [self.columnHeights[0] doubleValue];
    
    for (int i = 0; i < self.columnCount ; i++) {
        if (minHeight > [self.columnHeights[i] doubleValue]) {
            minHeight = [self.columnHeights[i] doubleValue];
            destColumn = i;
        }
    }
    
    CGFloat h = [self.delegate waterflowLayout:self heightForItemAtIndex:indexPath.item itemWidth:w];
    
    CGFloat x = self.edgeInsets.left + destColumn * (w +  self.columnMargin);
    
    CGFloat y = minHeight;
    if(y != self.edgeInsets.top) {
        y += self.rowMargin;
    }
    
    attr.frame = CGRectMake(x, y, w, h);
    
    self.columnHeights[destColumn] = @(y + h);
    
    return attr;
}

- (CGSize)collectionViewContentSize
{
    NSInteger maxHeight = [self.columnHeights[0] doubleValue];
    
    for (int i = 0; i<DefaultColumnCount; i++) {
        if (maxHeight < [self.columnHeights[i] doubleValue]) {
            maxHeight = [self.columnHeights[i] doubleValue];
        }
    }
    
    
    
    return CGSizeMake(0, maxHeight + self.edgeInsets.bottom);
    
}
@end
