//
//  SSClerkDiagnosisResultHeaderView.m
//  SunSum
//
//  Created by hank on 2019/4/16.
//  Copyright © 2019 hank. All rights reserved.
//

#import "SSClerkDiagnosisResultHeaderView.h"
#import "SSClerkDiagnosisResultmodel.h"

@interface SSClerkDiagnosisResultHeaderView ()

@property (weak, nonatomic) IBOutlet UILabel *lblNew;
@property (weak, nonatomic) IBOutlet UILabel *lblqz;
@property (weak, nonatomic) IBOutlet UILabel *lblAttend;
@property (weak, nonatomic) IBOutlet UILabel *lblOld;


@end


@implementation SSClerkDiagnosisResultHeaderView



- (void)setUiWithModel:(SSClerkDiagnosisResultmodel *)model{
    _lblNew.text = [@(model.thisMonthCustomerGrowth.new_customer).description stringByAppendingString:@"人"];
    _lblqz.text = [@(model.thisMonthCustomerGrowth.potential_customer).description stringByAppendingString:@"人"];
    _lblAttend.text = [@(model.thisMonthCustomerGrowth.Intention_customer).description stringByAppendingString:@"人"];
    _lblOld.text = [@(model.thisMonthCustomerGrowth.regular_customer).description stringByAppendingString:@"人"];
}

@end
