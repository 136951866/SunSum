//
//  SSBdataStoreCustomerTopCell.m
//  SunSum
//
//  Created by hank on 2019/3/20.
//  Copyright © 2019 hank. All rights reserved.
//

#import "SSBdataStoreCustomerTopCell.h"
#import "SSBDataDealModel.h"

@interface SSBdataStoreCustomerTopCell ()


@property (weak, nonatomic) IBOutlet UILabel *lblSpendTimes;
@property (weak, nonatomic) IBOutlet UILabel *lblSpendMax;
@property (weak, nonatomic) IBOutlet UILabel *lblSpendAmount;
@property (weak, nonatomic) IBOutlet UILabel *lblNewsDealTimes;
@property (weak, nonatomic) IBOutlet UILabel *lblNewsDealAmount;
@property (weak, nonatomic) IBOutlet UILabel *lblSpendMaxTitle;

@end

@implementation SSBdataStoreCustomerTopCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = 0;
    _lblSpendMaxTitle.adjustsFontSizeToFitWidth = YES;
}

- (void)setUIWithModel:(SSBDataDealModel *)model{
    _lblSpendTimes.text = kMeUnNilStr(model.storeCustomer.spendTimes);
    _lblSpendMax.text = kMeUnNilStr(model.storeCustomer.spendMax);
    _lblSpendAmount.text = kMeUnNilStr(model.storeCustomer.spendAmount);
    _lblNewsDealTimes.text = kMeUnNilStr(model.storeCustomer.newsDealTimes);
    _lblNewsDealAmount.text = kMeUnNilStr(model.storeCustomer.newsDealAmount);
}

@end
