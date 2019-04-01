//
//  SSGiftMainCell.m
//  SunSum
//
//  Created by hank on 2018/12/20.
//  Copyright © 2018年 hank. All rights reserved.
//

#import "SSGiftMainCell.h"
#import "SSGiftMainContentCell.h"
#import "SSShoppingCartModel.h"
@interface SSGiftMainCell ()<UITableViewDelegate,UITableViewDataSource>{
    kMeBasicBlock _block;

}

@property (weak, nonatomic) IBOutlet UITableView *tableVIew;
@property (weak, nonatomic) IBOutlet UILabel *lblNum;
@property (nonatomic, strong) NSMutableArray *arrData;


@end

@implementation SSGiftMainCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = 0;
    self.backgroundColor = [UIColor clearColor];
    _arrData = [NSMutableArray array];
    [_tableVIew registerNib:[UINib nibWithNibName:NSStringFromClass([SSGiftMainContentCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([SSGiftMainContentCell class])];
    _tableVIew.rowHeight = kSSGiftMainContentCellHeight;
    _tableVIew.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableVIew.showsVerticalScrollIndicator = NO;
    _tableVIew.scrollEnabled = NO;
    _tableVIew.bounces = NO;
    _tableVIew.delegate = self;
    _tableVIew.dataSource = self;
    _tableVIew.tableFooterView = [UIView new];
    // Initialization code
}

- (void)setUIWithModel:(NSArray *)model block:(kMeBasicBlock)block{
    _block = block;
    _arrData = [NSMutableArray arrayWithArray:model];
    _lblNum.text = [NSString stringWithFormat:@"共%@件",@(_arrData.count)];
    [self.tableVIew reloadData];
}

- (IBAction)continuAction:(UIButton *)sender {
    kMeCallBlock(_block);
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _arrData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SSGiftMainContentCell *cell=[tableView dequeueReusableCellWithIdentifier:NSStringFromClass([SSGiftMainContentCell class]) forIndexPath:indexPath];
    SSShoppingCartModel *goodsModel = _arrData[indexPath.row];
    kMeWEAKSELF
    cell.AddBlock = ^(UILabel *countLabel) {
        kMeSTRONGSELF
        goodsModel.goods_num = [countLabel.text integerValue];
        [strongSelf.arrData replaceObjectAtIndex:indexPath.row withObject:goodsModel];
        [strongSelf countPrice];
    };
    cell.CutBlock = ^(UILabel *countLabel) {
        kMeSTRONGSELF
        goodsModel.goods_num = [countLabel.text integerValue];
        [strongSelf.arrData replaceObjectAtIndex:indexPath.row withObject:goodsModel];
        [strongSelf countPrice];
    };
    SSShoppingCartModel *model = _arrData[indexPath.row];
    [cell setUIWIthModel:model];
    return cell;
}

- (void)countPrice{
    double totlePrice = 0.0;
    for (SSShoppingCartModel *goodsModel in _arrData) {
        double price = [goodsModel.money doubleValue];
        totlePrice += price * goodsModel.goods_num ;
    }
    NSString *price= [NSString stringWithFormat:@"￥%.2f", totlePrice];
    kMeCallBlock(_allPriceBlock,price);
}
    
+ (CGFloat)getCellHeightWithModel:(NSArray *)model{
    if(model.count == 0){
        return 0;
    }
    CGFloat height = 40;
    height+=model.count *kSSGiftMainContentCellHeight;
    return height;
}

@end
