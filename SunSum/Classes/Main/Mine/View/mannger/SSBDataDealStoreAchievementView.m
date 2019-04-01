//
//  SSBDataDealStoreAchievementView.m
//  SunSum
//
//  Created by hank on 2019/2/26.
//  Copyright © 2019 hank. All rights reserved.
//

#import "SSBDataDealStoreAchievementView.h"
#import "SSBDataDealStructView.h"
#import "SSBDataDealModel.h"

@interface SSBDataDealStoreAchievementView ()

@property (weak, nonatomic) IBOutlet UILabel *lblAchievementMemberNew;
@property (weak, nonatomic) IBOutlet UILabel *lblAchievementMemberOld;
@property (weak, nonatomic) IBOutlet UILabel *lblAchievementMemberActive;
@property (weak, nonatomic) IBOutlet UILabel *lblAchievementMouth;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *consStructView;
@property (weak, nonatomic) IBOutlet SSBDataDealStructView *viewforStruct;

@end

@implementation SSBDataDealStoreAchievementView

- (void)awakeFromNib{
    [super awakeFromNib];
}

- (void)setUIWithModel:(SSBDataDealModel *)model{
//    _lblAchievementMemberNew.text = kMeUnNilStr(model.storeAchievement.AchievementMember.people);
//    _lblAchievementMemberOld.text = kMeUnNilStr(model.storeAchievement.AchievementMember.old);
//    _lblAchievementMemberActive.text = kMeUnNilStr(model.storeAchievement.AchievementMember.active);
//    _lblAchievementMouth.text = kMeUnNilStr(model.storeAchievement.AchievementMouth);
//    [_viewforStruct setUIWithArr:kMeUnArr(model.storeAchievement.AchievementCatagery)];
//    _consStructView.constant = [SSBDataDealStructView getViewWithArr:kMeUnArr(model.storeAchievement.AchievementCatagery)];
}

+(CGFloat)getViewHeightWithModel:(SSBDataDealModel *)model{
    CGFloat height = 430-128;
    height+=[SSBDataDealStructView getViewWithArr:kMeUnArr(model.storeAchievement.AchievementCatagery)];
    return height;
}

@end
