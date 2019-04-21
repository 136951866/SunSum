//
//  SSFFourCaseVC.m
//  SunSum
//
//  Created by hank on 2019/4/21.
//  Copyright © 2019 hank. All rights reserved.
//

#import "SSFFourCaseVC.h"
#import "SSFFourCaseHeaderView.h"
#import "SSImageCell.h"

@interface SSFFourCaseVC ()<UITableViewDelegate,UITableViewDataSource>
{
    NSArray *_arrImage;
    NSInteger _currntIndex ;
}
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) SSFFourCaseHeaderView         *headerView;

@end

@implementation SSFFourCaseVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"方案";
    _arrImage = @[@"caseedu",@"caseedutour",@"caseeducar",@"caseeduzx"];
    _currntIndex = 0;
    [self.view addSubview:self.tableView];
}

#pragma mark - tableView deleagte and sourcedata

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SSImageCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([SSImageCell class]) forIndexPath:indexPath];
    if(_currntIndex < 4){
        NSString *str = _arrImage[_currntIndex];
        cell.imagePic.image = [UIImage imageNamed:kMeUnNilStr(str)];
        [cell layoutIfNeeded];
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(_currntIndex == 0){
        return SSImageEduCellHeight;
    }else if (_currntIndex == 1){
        return SSImageTourCellHeight;
    }else if (_currntIndex == 2){
        return SSImageCarCellHeight;
    }else if (_currntIndex == 3){
        return SSImageZXCellHeight;
    }else{
        return 0.1;
    }
}

- (UITableView *)tableView{
    if(!_tableView){
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, kMeNavBarHeight, SCREEN_WIDTH, SCREEN_HEIGHT-kMeNavBarHeight) style:UITableViewStylePlain];
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([SSImageCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([SSImageCell class])];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.tableHeaderView = self.headerView;
        _tableView.tableHeaderView.backgroundColor = [UIColor colorWithHexString:@"ececec"];;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor colorWithHexString:@"ececec"];
        _tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    }
    return _tableView;
}

- (SSFFourCaseHeaderView *)headerView{
    if(!_headerView){
        _headerView = [[[NSBundle mainBundle]loadNibNamed:@"SSFFourCaseHeaderView" owner:nil options:nil] lastObject];
        _headerView.frame =CGRectMake(0, 0, SCREEN_WIDTH,kSSFFourCaseHeaderViewHeight);
        kMeWEAKSELF
        _headerView.selectBlock = ^(NSInteger index) {
            kMeSTRONGSELF
            strongSelf->_currntIndex = index;
            [strongSelf.tableView reloadData];
        };
    }
    return _headerView;
}


@end
