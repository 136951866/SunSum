//
//  SSClerkSortCell.m
//  SunSum
//
//  Created by hank on 2019/4/12.
//  Copyright © 2019 hank. All rights reserved.
//

#import "SSClerkSortCell.h"
#import "SSClerkSortContentCell.h"
#import "SSNewClerkManngerModel.h"

@interface SSClerkSortCell ()<UITableViewDelegate,UITableViewDataSource>
{
    NSArray *_arrdata;
    NSInteger _currentIndex;
    kMeIndexBlock _block;
}

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIButton *btnShare;
@property (weak, nonatomic) IBOutlet UIButton *btnGt;
@property (weak, nonatomic) IBOutlet UIButton *btnCustomer;

@end

@implementation SSClerkSortCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = 0;
    _arrdata = [NSArray array];
    [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([SSClerkSortContentCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([SSClerkSortContentCell class])];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    _tableView.rowHeight = kSSClerkSortContentCellHeight;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.scrollEnabled = NO;
    _tableView.bounces = NO;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = kSSf6f5fa;
    
    [_btnShare setBackgroundImage:[SSCommonTool createImageWithColor:[UIColor colorWithHexString:@"169DFF"]] forState:UIControlStateSelected];
    [_btnGt setBackgroundImage:[SSCommonTool createImageWithColor:[UIColor colorWithHexString:@"169DFF"]] forState:UIControlStateSelected];
    [_btnCustomer setBackgroundImage:[SSCommonTool createImageWithColor:[UIColor colorWithHexString:@"169DFF"]] forState:UIControlStateSelected];
    _currentIndex = 0;
}

- (IBAction)btnActon:(UIButton *)sender {
    NSInteger index = sender.tag - 1000;
    if(_currentIndex == index){
        return;
    }
    UIButton *currentBtn = [self viewWithTag:_currentIndex+1000];
    currentBtn.selected = NO;
    sender.selected = YES;
    _currentIndex = index;
    kMeCallBlock(_block,index);;
}


- (void)setUIWithArr:(NSArray *)arr selectBlock:(kMeIndexBlock)selectBlock selectIndex:(NSInteger)selectIndex{
    _arrdata = kMeUnArr(arr);
    _block = selectBlock;
    _currentIndex = selectIndex;
    UIButton *currentBtn = [self viewWithTag:_currentIndex+1000];
    currentBtn.selected = YES;
    _tableView.hidden = !kMeUnArr(_arrdata).count;
    [self.tableView reloadData];
}

#pragma mark - tableView deleagte and sourcedata

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _arrdata.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SSClerkSortContentCell *cell=[tableView dequeueReusableCellWithIdentifier:NSStringFromClass([SSClerkSortContentCell class]) forIndexPath:indexPath];
    SSNewClerkManngerDataContentModel *model = _arrdata[indexPath.row];
    [cell setUIWIthModel:model sort:indexPath.row type:_currentIndex];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

+ (CGFloat)getCellHeightWithArr:(NSArray *)arr{
    CGFloat height = kSSClerkSortCellOrgialHeight;
    height +=(kMeUnArr(arr).count * kSSClerkSortContentCellHeight);
    return height;
}


@end

