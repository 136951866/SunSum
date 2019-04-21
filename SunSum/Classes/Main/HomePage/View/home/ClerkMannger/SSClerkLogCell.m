//
//  SSClerkLogCell.m
//  SunSum
//
//  Created by hank on 2019/4/12.
//  Copyright © 2019 hank. All rights reserved.
//

#import "SSClerkLogCell.h"
#import "SSClerkLogContentCell.h"
#import "SSNewClerkManngerModel.h"

@interface SSClerkLogCell ()<UITableViewDelegate,UITableViewDataSource>
{
    NSArray *_arrdata;
}

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UILabel *lblToday;
@property (weak, nonatomic) IBOutlet UILabel *lblWait;
@property (weak, nonatomic) IBOutlet UILabel *lblOut;
@property (weak, nonatomic) IBOutlet UILabel *lblFinish;
@property (weak, nonatomic) IBOutlet UIImageView *imgArrow;



@end

@implementation SSClerkLogCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = 0;
    _arrdata = [NSArray array];
    [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([SSClerkLogContentCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([SSClerkLogContentCell class])];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    _tableView.rowHeight = kSSClerkLogContentCellHeight;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.scrollEnabled = NO;
    _tableView.bounces = NO;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = kSSf6f5fa;
}

- (void)setUIWithArr:(SSNewClerkManngerModel *)model{
    if(kCurrentUser.client_type == SSClientBTypeStyle){
        _lblFinish.hidden = YES;
        _imgArrow.hidden = YES;
    }else{
        _lblFinish.hidden = NO;
        _imgArrow.hidden = NO;
    }
    _arrdata = @[];//kMeUnArr(model.clerk_task_service.client);
    _tableView.hidden = !kMeUnArr(_arrdata).count;
    _lblToday.text = kMeUnNilStr(model.clerk_task_service.clerk_today_log_count);
    _lblWait.text = kMeUnNilStr(model.clerk_task_service.wait_servcie_count);
    _lblOut.text = kMeUnNilStr(model.clerk_task_service.overdue_count);
    [self.tableView reloadData];
}

- (void)setLogUIWithArr:(SSNewClerkManngerClerkTaskServiceModel *)model{
    if(kCurrentUser.client_type == SSClientBTypeStyle){
        _lblFinish.hidden = YES;
        _imgArrow.hidden = YES;
    }else{
        _lblFinish.hidden = NO;
        _imgArrow.hidden = NO;
    }
    _arrdata = @[];//kMeUnArr(model.clerk_task_service.client);
    _tableView.hidden = !kMeUnArr(_arrdata).count;
    _lblToday.text = kMeUnNilStr(model.clerk_today_log_count);
    _lblWait.text = kMeUnNilStr(model.wait_servcie_count);
    _lblOut.text = kMeUnNilStr(model.overdue_count);
    [self.tableView reloadData];
}

#pragma mark - tableView deleagte and sourcedata

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return kCurrentUser.client_type == SSClientBTypeStyle?0:_arrdata.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SSClerkLogContentCell *cell=[tableView dequeueReusableCellWithIdentifier:NSStringFromClass([SSClerkLogContentCell class]) forIndexPath:indexPath];
    SSNewClerkManngerClerkTaskclientModel *model = _arrdata[indexPath.row];
    [cell setUIWIthModel:model];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    kMeCallBlock(_selectIndexBlock,indexPath.row);
}

+ (CGFloat)getCellHeightWithArr:(SSNewClerkManngerModel *)model{
    CGFloat height = kSSClerkLogCellOrgialHeight;
//    if(kCurrentUser.client_type == SSClientBTypeStyle){
//    }else{
//        NSArray *arr = kMeUnArr(model.clerk_task_service.client);
//        height +=(kMeUnArr(arr).count * kSSClerkLogContentCellHeight);
//    }
    return height;
}


@end
