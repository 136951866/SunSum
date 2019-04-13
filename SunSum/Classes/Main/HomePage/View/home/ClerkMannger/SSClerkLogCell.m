//
//  SSClerkLogCell.m
//  SunSum
//
//  Created by hank on 2019/4/12.
//  Copyright © 2019 hank. All rights reserved.
//

#import "SSClerkLogCell.h"
#import "SSClerkLogContentCell.h"

@interface SSClerkLogCell ()<UITableViewDelegate,UITableViewDataSource>
{
    NSArray *_arrdata;
}

@property (weak, nonatomic) IBOutlet UITableView *tableView;

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

- (void)setUIWithArr:(NSArray *)arr{
    _arrdata = arr;
    _tableView.hidden = !kMeUnArr(_arrdata).count;
    [self.tableView reloadData];
}

#pragma mark - tableView deleagte and sourcedata

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _arrdata.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SSClerkLogContentCell *cell=[tableView dequeueReusableCellWithIdentifier:NSStringFromClass([SSClerkLogContentCell class]) forIndexPath:indexPath];
    [cell setUIWIthModel:@""];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

+ (CGFloat)getCellHeightWithArr:(NSArray *)arr{
    CGFloat height = kSSClerkLogCellOrgialHeight;
    height +=(kMeUnArr(arr).count * kSSClerkLogContentCellHeight);
    return height;
}


@end
