//
//  SSRushBuyCell.m
//  SunSum
//
//  Created by hank on 2019/1/21.
//  Copyright © 2019 hank. All rights reserved.
//

#import "SSRushBuyCell.h"
#import "SSRushBuyContentCell.h"
#import "SSThridHomeRudeGoodModel.h"
#import "SSThridHomeVC.h"
#import "SSThridProductDetailsVC.h"
#import "SSThridRushSpikeVC.h"

@interface SSRushBuyCell ()<UITableViewDelegate,UITableViewDataSource>{
    NSArray *_arrModel;
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation SSRushBuyCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self initSomething];
}

- (void)initSomething{
    self.selectionStyle = 0;
    [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([SSRushBuyContentCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([SSRushBuyContentCell class])];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.scrollEnabled = NO;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return kSSRushBuyContentCellHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SSRushBuyContentCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([SSRushBuyContentCell class]) forIndexPath:indexPath];
    SSThridHomeRudeGoodModel *model = _arrModel[indexPath.row];
    [cell setUIWithModel:model];
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _arrModel.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    SSThridHomeRudeGoodModel *model = _arrModel[indexPath.row];
    SSThridHomeVC *homeVC = (SSThridHomeVC *)[SSCommonTool getVCWithClassWtihClassName:[SSThridHomeVC class] targetResponderView:self];
    if(homeVC){
        SSThridProductDetailsVC *dvc = [[SSThridProductDetailsVC alloc]initWithId:model.product_id];
        dvc.time = self.time;
        [homeVC.navigationController pushViewController:dvc animated:YES];
    }else{
        SSThridRushSpikeVC *rushVC = (SSThridRushSpikeVC *)[SSCommonTool getVCWithClassWtihClassName:[SSThridRushSpikeVC class] targetResponderView:self];
        if(rushVC){
            SSThridProductDetailsVC *dvc = [[SSThridProductDetailsVC alloc]initWithId:model.product_id];
            dvc.time = self.time;
            [rushVC.navigationController pushViewController:dvc animated:YES];
        }
    }
}

- (void)setUIWithArr:(NSArray *)arr{
    _arrModel = arr;
    [self.tableView reloadData];
}

+ (CGFloat)getCellHeightWithArr:(NSArray *)arr{
    NSInteger num = kMeUnArr(arr).count;
    return num *kSSRushBuyContentCellHeight;
}



@end
