//
//  SSBynamicCommentView.m
//  SunSum
//
//  Created by hank on 2019/1/23.
//  Copyright © 2019 hank. All rights reserved.
//

#import "SSBynamicCommentView.h"
#import "SSBynamicCommentCell.h"
#import "SSBynamicLikeCell.h"
#import "SSBynamicHomeModel.h"

#define kSSSSBynamicCommentViewW (SCREEN_WIDTH-(10+36+10+10))

@interface SSBynamicCommentView ()<UITableViewDelegate,UITableViewDataSource>{

}

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *arrLike;
@property (nonatomic, strong) NSArray *arrComment;
@end

@implementation SSBynamicCommentView

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    if(self = [super initWithCoder:aDecoder]){
        [self setSubView];
    }
    return self;
}

- (void)setSubView{
    [self addSubview:self.tableView];
    UIImageView *img = [[UIImageView alloc]initWithFrame:CGRectMake(20, 0, 10, 7)];
    img.image = [UIImage imageNamed:@"arrowCommon"];
    [self addSubview:img];
}

- (void)setUIWithArrLike:(NSArray *)arrLike Arrcomment:(NSArray*)arrcomment{
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    CGFloat height = [SSBynamicCommentView getViewHeightWithArrLike:arrLike Arrcomment:arrcomment];
    self.tableView.frame = CGRectMake(0, 7, kSSSSBynamicCommentViewW, height-7);
    _arrLike = arrLike;
    _arrComment = arrcomment;
    [self.tableView reloadData];
}

#pragma mark - tableView deleagte and sourcedata

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(section){
        return _arrComment.count;
    }else{
        return _arrLike.count?1:0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section){
        SSBynamicHomecommentModel *model = _arrComment[indexPath.row];
        SSBynamicCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([SSBynamicCommentCell class]) forIndexPath:indexPath];
        [cell setUIWithModel:model];
        return cell;
    }else{
        SSBynamicLikeCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([SSBynamicLikeCell class]) forIndexPath:indexPath];
        [cell setUIWithModel:_arrLike];
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section){
        SSBynamicHomecommentModel *model = _arrComment[indexPath.row];
        return [SSBynamicCommentCell getCellHeightWithhModel:model];
    }else{
        return [SSBynamicLikeCell getCellHeightWithhModel:_arrLike];
    }
}


- (UITableView *)tableView{
    if(!_tableView){
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 7, kSSSSBynamicCommentViewW, self.height) style:UITableViewStylePlain];
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([SSBynamicLikeCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([SSBynamicLikeCell class])];
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([SSBynamicCommentCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([SSBynamicCommentCell class])];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.tableFooterView = [UIView new];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor colorWithHexString:@"f4f5f7"];
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.width, 8)];
        view.backgroundColor = [UIColor colorWithHexString:@"f4f5f7"];
        _tableView.tableHeaderView = view;
        _tableView.tableFooterView = [UIView new];
        _tableView.cornerRadius = 2;
        _tableView.clipsToBounds = YES;
        _tableView.scrollEnabled = NO;
    }
    return _tableView;
}

+ (CGFloat )getViewHeightWithArrLike:(NSArray *)arrLike Arrcomment:(NSArray*)arrcomment{
    CGFloat height = 0;
    if(arrLike.count){
        height += [SSBynamicLikeCell getCellHeightWithhModel:arrLike];
    }
    for (NSInteger i=0; i<arrcomment.count; i++) {
        SSBynamicHomecommentModel *model = arrcomment[i];
        height += [SSBynamicCommentCell getCellHeightWithhModel:model];
    }
    if(arrLike.count || arrcomment.count){
        height+=8+7;
    }
    return height;
}

@end
