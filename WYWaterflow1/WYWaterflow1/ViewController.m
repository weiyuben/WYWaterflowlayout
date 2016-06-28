//
//  ViewController.m
//  WYWaterflow1
//
//  Created by weibenyu on 16/6/21.
//  Copyright © 2016年 weibenyu. All rights reserved.
//

#import "ViewController.h"
#import "WYWaterflowlayout.h"

@interface ViewController ()<UICollectionViewDataSource, WYWaterflowlayoutDelegate>
/**collectionView*/
@property (nonatomic ,strong)UICollectionView *collectionView;
@end

NSString *cellID = @"cellId";

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    WYWaterflowlayout *layout = [[WYWaterflowlayout alloc]init];
    layout.delegate = self;
    
    self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 20, self.view.bounds.size.width, self.view.bounds.size.height - 20)collectionViewLayout:layout];
    
    self.collectionView.dataSource = self;
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:cellID];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.collectionView];
    
}




- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return  50;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    
    cell.backgroundColor = [UIColor yellowColor];
    
    return cell;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -waterflowlayoutDelegate

- (CGFloat)waterflowLayout:(WYWaterflowlayout *)waterflowLayout heightForItemAtIndex:(NSInteger)index itemWidth:(CGFloat)itemWidth
{
    return (arc4random_uniform(100) + 50);
}


- (UIEdgeInsets)edgeInsetsInWaterflowLayout:(WYWaterflowlayout *)waterflowLayout
{
    return  UIEdgeInsetsMake(10, 10, 10, 10);
}

-(CGFloat)rowMarginInWaterflowLayout:(WYWaterflowlayout *)waterflowLayout
{
    return 5;
}

- (CGFloat)columnCountInWaterflowLayout:(WYWaterflowlayout *)waterflowLayout
{
    return  3;
}

- (CGFloat)columnMarginInWaterflowLayout:(WYWaterflowlayout *)waterflowLayout
{
    return 5;
}
@end

