//
//  SSGoodManngerSpecMainCell.m
//  SunSum
//
//  Created by hank on 2019/3/28.
//  Copyright © 2019 hank. All rights reserved.
//

#import "SSGoodManngerSpecMainCell.h"
#import "SSGoodManngerSpecBasicCell.h"
#import "SSGoodManngerSpecAddCell.h"
#import "SSGoodManngerAddSpecModel.h"
#import "SSGoodManngerGoodSpec.h"

@interface SSGoodManngerSpecMainCell ()<UITableViewDelegate,UITableViewDataSource>{
}

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) SSGoodManngerAddSpecModel *model;

@end

@implementation SSGoodManngerSpecMainCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = 0;
    [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([SSGoodManngerSpecBasicCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([SSGoodManngerSpecBasicCell class])];
    [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([SSGoodManngerSpecAddCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([SSGoodManngerSpecAddCell class])];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.scrollEnabled = NO;
    _tableView.delegate = self;
    _tableView.dataSource = self;
}

- (void)setUiWihtModel:(SSGoodManngerAddSpecModel*)model{
    _model = model;
    [self.tableView reloadData];
}

- (IBAction)delAction:(UIButton *)sender {
    kMeCallBlock(_delBlock);
}


+ (CGFloat)getCellHeightWithModel:(SSGoodManngerAddSpecModel*)model{
    CGFloat height = 65;
    NSInteger count = [kMeUnArr(model.arrSpec) count];
    height+=(kSSGoodManngerSpecBasicCellHeight + (count *kSSGoodManngerSpecAddCellHeight));
    return height;
}

#pragma mark ------------------ <UITableViewDelegate, UITableViewDataSource> ----
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if(section == 0){
        return [kMeUnArr(_model.arrSpec) count];
    }else{
        return 1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.section == 0){
        SSGoodManngerGoodSpec *model = kMeUnArr(_model.arrSpec)[indexPath.row];
        SSGoodManngerSpecAddCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([SSGoodManngerSpecAddCell class]) forIndexPath:indexPath];
        [cell setUIWithModel:model];
        return cell;
    }else{
        SSGoodManngerSpecBasicCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([SSGoodManngerSpecBasicCell class]) forIndexPath:indexPath];
        [cell setUiWihtModel:_model];
        __weak typeof(cell) weakCell = cell;
        kMeWEAKSELF
        cell.touchImgBlock = ^{
            kMeSTRONGSELF
            kMeCallBlock(strongSelf->_tapImgBlock,weakCell);
        };
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.section == 0){
        return kSSGoodManngerSpecAddCellHeight;
    }else{
        return kSSGoodManngerSpecBasicCellHeight;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
}


@end
