//
//  SSJDCoupleHomeVC.m
//  SunSum
//
//  Created by hank on 2019/2/18.
//  Copyright © 2019 hank. All rights reserved.
//

#import "SSJDCoupleHomeVC.h"
#import "SSCoupleHomeNavView.h"
#import "SSJDCoupleHomeMainGoodGoodsCell.h"
#import "SSAdModel.h"
#import "SSJDCoupleModel.h"
#import "SSJDCoupleMailDetalVC.h"
//NSUInteger const kJDSizeNum = 20;

@interface SSJDCoupleHomeVC ()<SDCycleScrollViewDelegate,UITableViewDelegate,UITableViewDataSource>{
    NSArray *_arrSdImage;
    NSMutableArray *_arrData;
    NSInteger _pageIndex;//当前页
//    NSInteger _allRows;//总数据
    
}

//@property(nonatomic,strong) SDCycleScrollView *cycleScrollView;
//@property (nonatomic, strong) SSCoupleHomeNavView *navView;
@property (nonatomic, strong) UITableView *tableView;


@end

@implementation SSJDCoupleHomeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"京东优惠卷";
//    self.navBarHidden = YES;
    _arrSdImage = @[];
    _arrData = [NSMutableArray array];
//    [self.view addSubview:self.navView];
    [self.view addSubview:self.tableView];
//    self.tableView.tableHeaderView = self.cycleScrollView;
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headrefresh)];
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(footerfresh)];
    self.tableView.mj_footer.hidden = YES;
    [self.tableView.mj_header beginRefreshing];
    // Do any additional setup after loading the view.
}

- (void)headrefresh{
    _pageIndex = 1;
    [self requestNetWorkIsHead:YES];
}

- (void)footerfresh{
//    NSInteger size = kJDSizeNum;
//    if(_pageIndex > _allRows/size){
//        [self.tableView.mj_footer endRefreshing];
//        [self.tableView.mj_footer endRefreshingWithNoMoreData];
//        return;
//    }
    ++ _pageIndex;
    [self requestNetWorkIsHead:NO];
}

- (void)reload{
    [ZLFailLoadView removeFromView:self.tableView];
    if (self.tableView.mj_header) {
        [self.tableView.mj_header beginRefreshing];
    }else{
        _pageIndex = 1;
        [_arrData removeAllObjects];
        [self requestNetWorkIsHead:YES];
    }
}

- (void)requestNetWorkIsHead:(BOOL)isHead{
    [ZLFailLoadView removeFromView:self.tableView];
    NSDictionary *dic = @{@"eliteId":@"16",
                          @"pageSize":@"20",
                          @"page":@(_pageIndex)
                          };
    NSString *url = kGetApiWithUrl(SSIPcommonjingdonggoodsJingFen);
    
    kMeWEAKSELF
    [THTTPManager postWithParameter:dic strUrl:url success:^(ZLRequestResponse *responseObject) {
        kMeSTRONGSELF
        if([responseObject.data isKindOfClass:[NSArray class]]){
            if (strongSelf->_pageIndex == 1) {
                [strongSelf->_arrData removeAllObjects];
            }
            NSArray *dicArr = responseObject.data ;
            [strongSelf->_arrData addObjectsFromArray:[SSJDCoupleModel mj_objectArrayWithKeyValuesArray:responseObject.data]];
            [strongSelf.tableView reloadData];
            [strongSelf endRefreshIsHead:isHead count:dicArr.count];
            [strongSelf showFailLoadViewWithResponse:responseObject];
            if (strongSelf->_arrData.count > 0) strongSelf.tableView.mj_footer.hidden = NO;
        }
    } failure:^(id error) {
        kMeSTRONGSELF
        [strongSelf endRefreshIsHead:isHead count:1];
        [strongSelf.tableView reloadData];
        [strongSelf showFailLoadViewWithResponse:error];
        strongSelf.tableView.mj_footer.hidden = !(strongSelf->_arrData.count > 0);
    }];
}

- (void)showFailLoadViewWithResponse:(id)response{
    kMeWEAKSELF
    [ZLFailLoadView showInView:self.tableView response:response allData:_arrData refreshBlock:^{
        kMeSTRONGSELF
        [strongSelf reload];
    } editHandle:^(ZLFailLoadView *failView) {
        failView.backgroundColor = [UIColor clearColor];
        failView.lblOfNodata.text = @"未搜索到您需要的产品";
    }];
}

- (void)endRefreshIsHead:(BOOL)isHead count:(NSInteger)count{
    if (isHead) {
        [self.tableView.mj_header endRefreshing];
    }else{
        [self.tableView.mj_footer endRefreshing];
    }
    if (count==0) {
        [self.tableView.mj_footer endRefreshingWithNoMoreData];
    } else {
        [self.tableView.mj_footer resetNoMoreData];
    }
}

//- (void)setSdImageModel:(NSArray *)arrModel{
//    _arrSdImage = arrModel;
//    __block NSMutableArray *arrImage = [NSMutableArray array];
//    [arrModel enumerateObjectsUsingBlock:^(SSAdModel *model, NSUInteger idx, BOOL * _Nonnull stop) {
//        [arrImage addObject:kMeUnNilStr(model.ad_img)];
//    }];
//    self.cycleScrollView.contentMode = UIViewContentModeScaleAspectFill;
//    self.cycleScrollView.clipsToBounds = YES;
//    self.cycleScrollView.imageURLStringsGroup = arrImage;
//}

//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
//    CGFloat imageh = (SCREEN_WIDTH*80)/750;
//    UIImageView *img = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"goodgoods"]];
//    img.frame = CGRectMake(0, 0, SCREEN_WIDTH, imageh);
//    return img;
//}

//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
//    return (SCREEN_WIDTH*80)/750;
//}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SSJDCoupleHomeMainGoodGoodsCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([SSJDCoupleHomeMainGoodGoodsCell class]) forIndexPath:indexPath];
    [cell setUIWithArr:_arrData];
    kMeWEAKSELF
    cell.selectBlock = ^(NSInteger index) {
        kMeSTRONGSELF
        SSJDCoupleModel *model = strongSelf->_arrData[index];
        SSJDCoupleMailDetalVC *vc = [[SSJDCoupleMailDetalVC alloc]initWithModel:model];
        [self.navigationController pushViewController:vc animated:YES];
    };
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [SSJDCoupleHomeMainGoodGoodsCell getCellHeightWithArr:_arrData];
}

#pragma mark - SDCycleScrollViewDelegate

- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{
    SSAdModel *model = kMeUnArr(_arrSdImage)[index];
    
}

//- (SDCycleScrollView *)cycleScrollView{
//    if(!_cycleScrollView){
//        _cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 150 *kMeFrameScaleX()) imageURLStringsGroup:nil];
//        _cycleScrollView.contentMode = UIViewContentModeScaleAspectFill;
//        _cycleScrollView.clipsToBounds = YES;
//        _cycleScrollView.pageControlAliment = SDCycleScrollViewPageContolAlimentCenter;
//        _cycleScrollView.pageControlStyle =SDCycleScrollViewPageContolStyleClassic;
//        _cycleScrollView.autoScrollTimeInterval = 4;
//        _cycleScrollView.delegate =self;
//        _cycleScrollView.backgroundColor = [UIColor clearColor];
//        _cycleScrollView.placeholderImage = kImgBannerPlaceholder;
//        _cycleScrollView.currentPageDotColor = kSSPink;
//    }
//    return _cycleScrollView;
//}

- (UITableView *)tableView{
    if(!_tableView){
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, kMeNavBarHeight, SCREEN_WIDTH, SCREEN_HEIGHT-kMeNavBarHeight) style:UITableViewStylePlain];
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([SSJDCoupleHomeMainGoodGoodsCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([SSJDCoupleHomeMainGoodGoodsCell class])];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = kSSf5f4f4;
    }
    return _tableView;
}

//- (SSCoupleHomeNavView *)navView{
//    if(!_navView){
//        _navView = [[[NSBundle mainBundle]loadNibNamed:@"SSCoupleHomeNavView" owner:nil options:nil] lastObject];
//        _navView.frame =CGRectMake(0, 0, SCREEN_WIDTH, kMeNavBarHeight);
//        kMeWEAKSELF
//        _navView.backBlock = ^{
//            kMeSTRONGSELF
//            [strongSelf.navigationController popViewControllerAnimated:YES];
//        };
//        _navView.searchBlock = ^{
//
//        };
//    }
//    return _navView;
//}

@end
