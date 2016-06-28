//
//  WYWaterflowlayout.h
//  WYWaterflow1
//
//  Created by weibenyu on 16/6/21.
//  Copyright © 2016年 weibenyu. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WYWaterflowlayout;

@protocol WYWaterflowlayoutDelegate <NSObject>

@required
- (CGFloat)waterflowLayout:(WYWaterflowlayout *)waterflowLayout heightForItemAtIndex:(NSInteger)index itemWidth:(CGFloat)itemWidth;

@optional
- (CGFloat)columnCountInWaterflowLayout:(WYWaterflowlayout *)waterflowLayout;
- (CGFloat)columnMarginInWaterflowLayout:(WYWaterflowlayout *)waterflowLayout;
- (CGFloat)rowMarginInWaterflowLayout:(WYWaterflowlayout *)waterflowLayout;
- (UIEdgeInsets)edgeInsetsInWaterflowLayout:(WYWaterflowlayout *)waterflowLayout;

@end


@interface WYWaterflowlayout : UICollectionViewLayout
@property (nonatomic, assign)id<WYWaterflowlayoutDelegate> delegate;
@end
