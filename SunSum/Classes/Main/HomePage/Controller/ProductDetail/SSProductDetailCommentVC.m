//
//  SSProductDetailCommentVC.m
//  SunSum
//
//  Created by hank on 2019/1/23.
//  Copyright © 2019 hank. All rights reserved.
//

#import "SSProductDetailCommentVC.h"
#import "SSProductDetailCommentCell.h"
#import "SSThridProductCommentHeaderView.h"
#import "SSGoodDetailModel.h"
#import "SSGoodsCommentModel.h"

@interface SSProductDetailCommentVC ()<UITableViewDelegate,UITableViewDataSource,RefreshToolDelegate>{
    SSGoodDetailModel *_model;
    SSThridProductCommentHeaderViewType _type;
}
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) ZLRefreshTool         *refresh;
@property (nonatomic, strong) SSThridProductCommentHeaderView *headerView;;
@end

@implementation SSProductDetailCommentVC

- (instancetype)initWithModel:(SSGoodDetailModel *)model{
    if(self = [super init]){
        _model = model;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _type = SSThridProductCommentHeaderViewAllType;
    self.title = @"评论";
    [self.view addSubview:self.tableView];
    self.tableView.tableHeaderView = self.headerView;
    [self.headerView setUIWithModel:_model type:_type];
    [self.refresh addRefreshView];
    // Do any additional setup after loading the view.
}

- (NSDictionary *)requestParameter{
    return @{@"product_id":@(_model.product_id),@"comment_type":@(_type)};
}

- (void)handleResponse:(id)data{
    if(![data isKindOfClass:[NSArray class]]){
        return;
    }
    [self.refresh.arrData addObjectsFromArray:[SSGoodsCommentModel mj_objectArrayWithKeyValuesArray:data]];
}

#pragma mark - tableView deleagte and sourcedata

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.refresh.arrData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SSGoodsCommentModel *model = self.refresh.arrData[indexPath.row];
    SSProductDetailCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([SSProductDetailCommentCell class]) forIndexPath:indexPath];
    [cell setUiWIthModel:model];
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    SSGoodsCommentModel *model = self.refresh.arrData[indexPath.row];
    return [SSProductDetailCommentCell getCellHeightWithModel:model];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

}

#pragma MARK - Setter

- (UITableView *)tableView{
    if(!_tableView){
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, kMeNavBarHeight, SCREEN_WIDTH, SCREEN_HEIGHT-kMeNavBarHeight) style:UITableViewStylePlain];
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([SSProductDetailCommentCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([SSProductDetailCommentCell class])];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.tableFooterView = [UIView new];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 10)];
        view.backgroundColor = kSSededed;
        _tableView.backgroundColor = [UIColor whiteColor];
    }
    return _tableView;
}

- (SSThridProductCommentHeaderView *)headerView{
    if(!_headerView){
        _headerView = [[[NSBundle mainBundle]loadNibNamed:@"SSThridProductCommentHeaderView" owner:nil options:nil] lastObject];
        _headerView.frame = CGRectMake(0, 0, SCREEN_WIDTH,kSSThridProductCommentHeaderViewHeight);
        kMeWEAKSELF
        _headerView.selectBlock = ^(NSInteger index) {
            kMeSTRONGSELF
            strongSelf->_type = index;
            [strongSelf.refresh reload];
        };
    }
    return _headerView;
}

- (ZLRefreshTool *)refresh{
    if(!_refresh){
        _refresh = [[ZLRefreshTool alloc]initWithContentView:self.tableView url:kGetApiWithUrl(SSIPRecommenGetGoodsComment)];
        _refresh.delegate = self;
        _refresh.isDataInside = YES;
        _refresh.showMaskView = YES;
        [_refresh setBlockEditFailVIew:^(ZLFailLoadView *failView) {
            failView.lblOfNodata.text = @"没有评论";
        }];
    }
    return _refresh;
}

@end
