//
//  SSClerkPlanAchieveVC.m
//  SunSum
//
//  Created by hank on 2019/4/15.
//  Copyright © 2019 hank. All rights reserved.
//

#import "SSClerkPlanAchieveVC.h"
#import "SSClerkPlanAchieveHomeCell.h"
#import "kSSClerkPlanAchieveListCell.h"
#import "THDatePickerView.h"
#import "SSClerkTaskDetailVC.h"
#import "SSPickerYearMonthView.h"
@interface SSClerkPlanAchieveVC ()<UITableViewDelegate, UITableViewDataSource,RefreshToolDelegate>
{
    NSString *_currentTime;
}
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) ZLRefreshTool         *refresh;
@property (nonatomic, strong) UILabel *lblTime;
@end

@implementation SSClerkPlanAchieveVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"计划达成";
    _currentTime = [SSTimeTool getNowYearMonth];
    [self.view addSubview:self.tableView];
    [self.refresh addRefreshView];
}

- (void)selectTimeAction{
    kMeWEAKSELF
    SSPickerYearMonthView *view = [[SSPickerYearMonthView alloc]initWithSelectDaye:^(NSString *str) {
        kMeSTRONGSELF
        strongSelf->_currentTime = kMeUnArr(str);
        _lblTime.text = kMeUnArr(str);
    }];
    [kMeCurrentWindow endEditing:YES];
    [kMeCurrentWindow addSubview:view];
}

- (NSDictionary *)requestParameter{
    [self.refresh.arrData addObjectsFromArray:@[@"",@"",@"",@""]];
    return @{@"token":kMeUnNilStr(kCurrentUser.token)};
}

- (void)handleResponse:(id)data{
    if(![data isKindOfClass:[NSArray class]]){
        return;
    }
    [self.refresh.arrData addObjectsFromArray:[NSObject mj_objectArrayWithKeyValuesArray:data]];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if(section == 0){
        return 1;
    }else{
        return self.refresh.arrData.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.section == 0){
        SSClerkPlanAchieveHomeCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([SSClerkPlanAchieveHomeCell class]) forIndexPath:indexPath];
        [cell setUIWIthModel:@""];
        return cell;
    }else{
        NSObject *model = self.refresh.arrData[indexPath.row];
        kSSClerkPlanAchieveListCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([kSSClerkPlanAchieveListCell class]) forIndexPath:indexPath];
        [cell setUIWIthModel:model sort:indexPath.row+1];
        return cell;
    }

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.section == 0){
        return kSSClerkPlanAchieveHomeCellHeight;
    }else{
        return kkSSClerkPlanAchieveListCellHeight;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    SSClerkTaskDetailVC *vc = [[SSClerkTaskDetailVC alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if(section == 0){
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 37)];
        view.backgroundColor = [UIColor whiteColor];
        _lblTime = [SSView lblWithFram:CGRectMake(15, 0, SCREEN_WIDTH - 72, 37) textColor:kSS333333 str:kMeUnNilStr(_currentTime) font:kMeFont(11)];
        _lblTime.textAlignment = NSTextAlignmentRight;
        UIImageView *img = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"taskCal"]];
        img.frame = CGRectMake(_lblTime.right + 15, (37 - 12)/2, 13, 12);
        img.contentMode = UIViewContentModeScaleAspectFit;
        [view addSubview:_lblTime];
        [view addSubview:img];
        UIButton *btn = [SSView btnWithFrame:view.frame Img:nil title:@""];
        [btn addTarget:self action:@selector(selectTimeAction) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:btn];
        UIView *viewline = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 1)];
        viewline.backgroundColor = kSSf6f5fa;
        [view addSubview:viewline];
        return view;
    }else{
        return [UIView new];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if(section == 0){
        return 37;
    }else{
        return 0.1;
    }
}

- (UITableView *)tableView{
    if(!_tableView){
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0,kMeNavBarHeight, SCREEN_WIDTH, SCREEN_HEIGHT-kMeNavBarHeight) style:UITableViewStylePlain];
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([SSClerkPlanAchieveHomeCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([SSClerkPlanAchieveHomeCell class])];
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([kSSClerkPlanAchieveListCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([kSSClerkPlanAchieveListCell class])];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.tableFooterView = [UIView new];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor whiteColor];
    }
    return _tableView;
}

- (ZLRefreshTool *)refresh{
    if(!_refresh){
        _refresh = [[ZLRefreshTool alloc]initWithContentView:self.tableView url:kGetApiWithUrl(@"")];
        _refresh.delegate = self;
        _refresh.isDataInside = YES;
        _refresh.showFailView = NO;
        [_refresh setBlockEditFailVIew:^(ZLFailLoadView *failView) {
            failView.backgroundColor = [UIColor whiteColor];
            failView.lblOfNodata.text = @"没有任务";
        }];
    }
    return _refresh;
}


@end

