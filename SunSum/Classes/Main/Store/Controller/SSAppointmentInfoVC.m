//
//  SSAppointmentInfoVC.m
//  SunSum
//
//  Created by hank on 2018/9/12.
//  Copyright © 2018年 hank. All rights reserved.
//

#import "SSAppointmentInfoVC.h"
#import "SSAppointmentDateMainCell.h"
#import "SSAppointmentTimeMainCell.h"
#import "SSAppointmentMakeOrderVC.h"
#import "SSAppointAttrModel.h"
#import "SSStoreDetailModel.h"

const static CGFloat kBtnAppointHeight = 50;

@interface SSAppointmentInfoVC ()<UITableViewDelegate,UITableViewDataSource>{
    NSInteger _currentWeekIndex;
    NSInteger _currentTimeIndex;
    NSArray *_arrWeek;
    NSArray *_arrTime;
    SSServiceDetailsModel *_serviceDetailModel;
}

@property (nonatomic, strong) UITableView           *tableView;
@property (nonatomic, strong) UIButton           *btnAppoint;
@property (nonatomic, strong) SSAppointAttrModel              *attrModel;

@end

@implementation SSAppointmentInfoVC


- (instancetype)initWithAttrModel:(SSAppointAttrModel *)attrmodel serviceDetailModel:(SSServiceDetailsModel *)serviceDetailModel{
    if(self = [super init]){
        self.attrModel = attrmodel;
        _serviceDetailModel = serviceDetailModel;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _currentWeekIndex = 0;
    _currentTimeIndex = -1;
    _arrWeek = [SSTimeTool latelyWeekTime];
    _arrTime = [SSTimeTool getTime];
    self.title = @"预约时间";
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.btnAppoint];
}

- (void)toAppoint:(UIButton *)btn{
    
    if(_currentTimeIndex==-1){
        kMeAlter(@"提示", @"请选择时间");
        return;
    }
    
    
    
    SSTimeModel *wmodel = _arrWeek[_currentWeekIndex];
    SSTimeModel *tmodel = _arrTime[_currentTimeIndex];
    SSTimeModel *model = [SSTimeModel new];
    model.time = tmodel.time;
    model.yearAndMonth = wmodel.yearAndMonth;
    
    NSString *selectTime = [NSString stringWithFormat:@"%@ %@",wmodel.yearAndMonth,tmodel.time];
    if([SSCommonTool compareOneDay:[SSCommonTool getCurrentTimesWithFormat:@"Y-M-d HH:mm"] withAnotherDay:kMeUnNilStr(selectTime)]){
        kMeAlter(@"提示", @"时间已过时");
        return;
    }
    
    
    if(_block){
        kMeCallBlock(_block,model);
    }else{
        self.attrModel.arrive_time = [NSString stringWithFormat:@"%@ %@",model.yearAndMonth,model.time];
        SSAppointmentMakeOrderVC *appVC = [[SSAppointmentMakeOrderVC alloc]initWithAttrModel:self.attrModel serviceDetailModel:_serviceDetailModel];
        [self.navigationController pushViewController:appVC animated:YES];
    }
}

#pragma mark - tableView deleagte and sourcedata

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section == 0){
        SSAppointmentDateMainCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([SSAppointmentDateMainCell class]) forIndexPath:indexPath];
        [cell setUIWithArr:_arrWeek currentIndex:_currentWeekIndex];
        kMeWEAKSELF
        cell.selectBlock = ^(NSInteger index) {
            kMeSTRONGSELF
            strongSelf->_currentWeekIndex = index;
        };
        return cell;
    }else if(indexPath.section == 1){
        SSAppointmentTimeMainCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([SSAppointmentTimeMainCell class]) forIndexPath:indexPath];
        [cell setUIWithArr:_arrTime currentIndex:_currentTimeIndex];
        kMeWEAKSELF
        cell.selectBlock = ^(NSInteger index) {
            kMeSTRONGSELF
            strongSelf->_currentTimeIndex = index;
        };
        return cell;
    }else{
        return [UITableViewCell new];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section==0){
        return kSSAppointmentDateMainCellHeight;
    }else if(indexPath.section == 1){
        return [SSAppointmentTimeMainCell getCellHeightWithArr:_arrTime];
    }else{
        return 1;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"%ld",indexPath.row);

}


#pragma MARK - Setter

- (UITableView *)tableView{
    if(!_tableView){
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, kMeNavBarHeight, SCREEN_WIDTH, SCREEN_HEIGHT-kMeNavBarHeight-kBtnAppointHeight) style:UITableViewStylePlain];
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([SSAppointmentDateMainCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([SSAppointmentDateMainCell class])];
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([SSAppointmentTimeMainCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([SSAppointmentTimeMainCell class])];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.tableFooterView = [UIView new];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor whiteColor];
    }
    return _tableView;
}

- (UIButton *)btnAppoint{
    if(!_btnAppoint){
        _btnAppoint = [UIButton buttonWithType:UIButtonTypeCustom];
        _btnAppoint.frame = CGRectMake(0, SCREEN_HEIGHT - kBtnAppointHeight, SCREEN_WIDTH, kBtnAppointHeight);
        [_btnAppoint setTitle:@"提交预约" forState:UIControlStateNormal];
        _btnAppoint.titleLabel.font = kMeFont(15);
        [_btnAppoint setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_btnAppoint setBackgroundColor:kSSHexColor(@"cc9e69")];
        [_btnAppoint addTarget:self action:@selector(toAppoint:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btnAppoint;
}



@end
