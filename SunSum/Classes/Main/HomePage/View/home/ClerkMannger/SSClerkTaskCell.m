//
//  SSClerkTaskCell.m
//  SunSum
//
//  Created by hank on 2019/4/12.
//  Copyright © 2019 hank. All rights reserved.
//

#import "SSClerkTaskCell.h"
#import "SSClerkTaskContentCell.h"
#import "SSNewClerkManngerModel.h"

@interface SSClerkTaskCell ()<UITableViewDelegate,UITableViewDataSource>
{
    NSArray *_arrdata;
}

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UILabel *lblF;
@property (weak, nonatomic) IBOutlet UILabel *lblNotF;

@end

@implementation SSClerkTaskCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = 0;
    _arrdata = [NSArray array];
    [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([SSClerkTaskContentCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([SSClerkTaskContentCell class])];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    _tableView.rowHeight = kSSClerkTaskContentCellHeight;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.scrollEnabled = NO;
    _tableView.bounces = NO;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = kSSf6f5fa;
}

- (void)setUIWithArr:(SSNewClerkManngerModel *)model{
    _arrdata = kMeUnArr(model.clerk_task.clerk_finish_percent);
    _lblF.text = kMeUnNilStr(model.clerk_task.finish_task);
    _lblNotF.text = kMeUnNilStr(model.clerk_task.unfinish_task);
    _tableView.hidden = !kMeUnArr(_arrdata).count;
    [self.tableView reloadData];
}

#pragma mark - tableView deleagte and sourcedata

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _arrdata.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SSClerkTaskContentCell *cell=[tableView dequeueReusableCellWithIdentifier:NSStringFromClass([SSClerkTaskContentCell class]) forIndexPath:indexPath];
    SSNewClerkManngerClerkTaskpercentModel *model = _arrdata[indexPath.row];
    [cell setUIWIthModel:model];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

+ (CGFloat)getCellHeightWithArr:(SSNewClerkManngerModel *)model{
    CGFloat height = kSSClerkTaskCellOrgialHeight;
    NSArray *arr = kMeUnArr(model.clerk_task.clerk_finish_percent);
    height +=(kMeUnArr(arr).count * kSSClerkTaskContentCellHeight);
    return height;
}

- (IBAction)moreAction:(UIButton *)sender {
    kMeCallBlock(_moreBlock);
}



@end
