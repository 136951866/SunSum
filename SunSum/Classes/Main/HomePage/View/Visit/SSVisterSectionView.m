//
//  SSVisterSectionView.m
//  SunSum
//
//  Created by hank on 2018/11/28.
//  Copyright © 2018年 hank. All rights reserved.
//

#import "SSVisterSectionView.h"

@interface SSVisterSectionView ()
{
    MyEnumkSSVisterSectionViewType _type;
    kMeIndexBlock _tapBlock;
}
@property (weak, nonatomic) IBOutlet UIButton *btnall;
@property (weak, nonatomic) IBOutlet UIButton *btnHope;
@property (weak, nonatomic) IBOutlet UIButton *btnVisitor;

@end

@implementation SSVisterSectionView

- (void)setTypeWithType:(MyEnumkSSVisterSectionViewType)type block:(kMeIndexBlock)block{
    _type = type;
    _tapBlock = block;
    [self setTypeWith:type];
}

- (IBAction)allAction:(UIButton *)sender {
    kMeCallBlock(_tapBlock,MyEnumkSSVisterSectionViewAllType);
}

- (IBAction)hopeAction:(UIButton *)sender {
   kMeCallBlock(_tapBlock,MyEnumkSSVisterSectionViewHopeType);
}

- (IBAction)visterAction:(UIButton *)sender {
    kMeCallBlock(_tapBlock,MyEnumkSSVisterSectionViewVisterType);
}

- (void)setTypeWith:(MyEnumkSSVisterSectionViewType)type{
    switch (type) {
        case MyEnumkSSVisterSectionViewAllType:{
            [_btnall setTitleColor:[UIColor colorWithHexString:@"333333"] forState:UIControlStateNormal];
            _btnall.borderColor = [UIColor colorWithHexString:@"333333"];
            
            [_btnHope setTitleColor:[UIColor colorWithHexString:@"999999"] forState:UIControlStateNormal];
            _btnHope.borderColor = [UIColor colorWithHexString:@"999999"];
            
            [_btnVisitor setTitleColor:[UIColor colorWithHexString:@"999999"] forState:UIControlStateNormal];
            _btnVisitor.borderColor = [UIColor colorWithHexString:@"999999"];
        }
            break;
        case MyEnumkSSVisterSectionViewHopeType:{
            [_btnHope setTitleColor:[UIColor colorWithHexString:@"333333"] forState:UIControlStateNormal];
            _btnHope.borderColor = [UIColor colorWithHexString:@"333333"];
            
            [_btnall setTitleColor:[UIColor colorWithHexString:@"999999"] forState:UIControlStateNormal];
            _btnall.borderColor = [UIColor colorWithHexString:@"999999"];
            
            [_btnVisitor setTitleColor:[UIColor colorWithHexString:@"999999"] forState:UIControlStateNormal];
            _btnVisitor.borderColor = [UIColor colorWithHexString:@"999999"];
        }
            break;
        case MyEnumkSSVisterSectionViewVisterType:{
            [_btnVisitor setTitleColor:[UIColor colorWithHexString:@"333333"] forState:UIControlStateNormal];
            _btnVisitor.borderColor = [UIColor colorWithHexString:@"333333"];
            
            [_btnall setTitleColor:[UIColor colorWithHexString:@"999999"] forState:UIControlStateNormal];
            _btnall.borderColor = [UIColor colorWithHexString:@"999999"];
            
            [_btnHope setTitleColor:[UIColor colorWithHexString:@"999999"] forState:UIControlStateNormal];
            _btnHope.borderColor = [UIColor colorWithHexString:@"999999"];
        }
            break;
        default:
            break;
    }
}

@end
