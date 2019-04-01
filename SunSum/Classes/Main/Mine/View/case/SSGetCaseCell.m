//
//  SSGetCaseCell.m
//  SunSum
//
//  Created by hank on 2018/12/12.
//  Copyright © 2018年 hank. All rights reserved.
//

#import "SSGetCaseCell.h"
#import "SSGetCaseContentCell.h"
#import "SSGetCaseModel.h"

@interface SSGetCaseCell ()<UITableViewDelegate,UITableViewDataSource>{
    NSArray *_arrData;
    BOOL _isDataDeal;
}
@property (weak, nonatomic) IBOutlet UILabel *lblNo;
@property (weak, nonatomic) IBOutlet UILabel *lblStatus;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *consTableHeight;

    
@end

@implementation SSGetCaseCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = 0;
    [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([SSGetCaseContentCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([SSGetCaseContentCell class])];
//    _tableView.rowHeight = kSSGetCaseContentCellHeight;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.scrollEnabled = NO;
    _tableView.bounces = NO;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.tableFooterView = [UIView new];
    _tableView.tableHeaderView = [UIView new];
    // Initialization code
}

- (void)setUIWithModel:(SSGetCaseModel *)model{
    _isDataDeal = NO;
    _lblNo.text = kMeUnNilStr(model.order_sn);
    _lblStatus.text = kMeUnNilStr(model.order_goods_status_name);
    _arrData = kMeUnArr(model.goods);
    CGFloat height = 0;
    for (SSGetCaseContentModel *model in _arrData) {
        height += [SSGetCaseContentCell getCellHeightWithModel:model];
    }
    _consTableHeight.constant = height;
    [self.tableView reloadData];
}

- (void)setUIDataDealWIthModel:(SSGetCaseModel *)model{
    _isDataDeal = YES;
    _lblNo.text = kMeUnNilStr(model.order_sn);
    _lblStatus.hidden = YES;
    _arrData = kMeUnArr(model.goods);
    _consTableHeight.constant = kSSGetCaseContentCellHeight * kMeUnArr(_arrData).count;
    [self.tableView reloadData];
}

#pragma mark - tableView deleagte and sourcedata

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return kMeUnArr(_arrData).count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SSGetCaseContentCell *cell=[tableView dequeueReusableCellWithIdentifier:NSStringFromClass([SSGetCaseContentCell class]) forIndexPath:indexPath];
    if(_isDataDeal){
         SSGetCaseContentModel *model = kMeUnArr(_arrData)[indexPath.row];
        [cell setUIDataDealWIthModel:model];
    }else{
        SSGetCaseContentModel *model = kMeUnArr(_arrData)[indexPath.row];
        [cell setUIWIthModel:model];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(_isDataDeal){
        return kSSGetCaseContentCellHeight;
    }
    SSGetCaseContentModel *model = kMeUnArr(_arrData)[indexPath.row];
    return [SSGetCaseContentCell getCellHeightWithModel:model];
}

+ (CGFloat)getCellDataDealHeightWithModel:(SSGetCaseModel *)model{
    CGFloat height = 56;
    NSArray *arrdata =  kMeUnArr(model.goods);
    height += kSSGetCaseContentCellHeight * arrdata.count;
    return height;
}

+ (CGFloat)getCellHeightWithModel:(SSGetCaseModel *)model{
    CGFloat height = 56;
    NSArray *arrdata =  kMeUnArr(model.goods);
    for (SSGetCaseContentModel *model in arrdata) {
        height += [SSGetCaseContentCell getCellHeightWithModel:model];
    }
    return height;
}


@end
