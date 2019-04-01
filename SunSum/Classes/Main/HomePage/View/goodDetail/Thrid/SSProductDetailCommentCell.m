//
//  SSProductDetailCommentCell.m
//  SunSum
//
//  Created by hank on 2019/1/23.
//  Copyright © 2019 hank. All rights reserved.
//

#import "SSProductDetailCommentCell.h"
#import "SSNineGridView.h"
#import "SSStarControl.h"
#import "YBImageBrowser.h"
#import "SSGoodsCommentModel.h"

@interface SSProductDetailCommentCell()<YBImageBrowserDataSource>{
    SSGoodsCommentModel *_model;
    NSInteger _currentIndex;
}

@property (weak, nonatomic) IBOutlet UIImageView *imgHeader;
@property (weak, nonatomic) IBOutlet UILabel *lblName;
@property (weak, nonatomic) IBOutlet SSStarControl *starView;
@property (weak, nonatomic) IBOutlet UILabel *lblTitle;
@property (weak, nonatomic) IBOutlet SSNineGridView *viewForPhoto;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *consPhotoHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *consTitleHeight;
@property (weak, nonatomic) IBOutlet UILabel *lblSku;

@end

@implementation SSProductDetailCommentCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = 0;
    // Initialization code
}

- (void)setUiWIthModel:(SSGoodsCommentModel *)model{
    _model = model;
    _currentIndex = 0;
    kSDLoadImg(_imgHeader, kMeUnNilStr(model.header_pic));
    _lblName.text = kMeUnNilStr(model.nick_name);
    _lblSku.text = kMeUnNilStr(model.sku);
    _starView.score = model.value;
    [_viewForPhoto setImageViewWithArr:kMeUnArr(model.images)];
    kMeWEAKSELF
    _viewForPhoto.selectBlock = ^(NSInteger index) {
        kMeSTRONGSELF
        strongSelf->_currentIndex = index;
        YBImageBrowser *browser = [YBImageBrowser new];
        browser.dataSource = strongSelf;
        browser.currentIndex = index;
        [browser show];
    };
    _consPhotoHeight.constant = [SSNineGridView getViewHeightWIth:kMeUnArr(model.images)];
    NSString *str = kMeUnNilStr(model.comment);
    CGFloat titleHeight = [NSAttributedString heightForAtsWithStr:str font:[UIFont systemFontOfSize:14] width:(SCREEN_WIDTH - 20) lineH:0 maxLine:0];
    _consTitleHeight.constant = titleHeight>17?titleHeight:17;
    [_lblTitle setAtsWithStr:kMeUnNilStr(str) lineGap:0];
    [self layoutIfNeeded];
}

//YBImageBrowserDataSource 代理实现赋值数据
- (NSUInteger)yb_numberOfCellForImageBrowserView:(YBImageBrowser *)imageBrowser {
    return kMeUnArr(_model.images).count;
}
- (id<YBImageBrowserCellDataProtocol>)yb_imageBrowserView:(YBImageBrowserView *)imageBrowserView dataForCellAtIndex:(NSUInteger)index {
    YBImageBrowseCellData *data = [YBImageBrowseCellData new];
    NSString *urlStr = [kMeUnArr(_model.images) objectAtIndex:index];
    data.url = [NSURL URLWithString:urlStr];
    data.sourceObject = [_viewForPhoto.arrImageView objectAtIndex:_currentIndex];;
    return data;
}

+ (CGFloat)getCellHeightWithModel:(SSGoodsCommentModel *)model{
    CGFloat height = 10+10+40+10+15+10+10;
    NSString *str = kMeUnNilStr(model.comment);
    CGFloat titleHeight = [NSAttributedString heightForAtsWithStr:str font:[UIFont systemFontOfSize:14] width:(SCREEN_WIDTH - 20) lineH:0 maxLine:0];
    height+=titleHeight>17?titleHeight:17;
    CGFloat photoheight = [SSNineGridView getViewHeightWIth:kMeUnArr(model.images)];
    if(photoheight>0){
        height+=(14+photoheight);
    }else{
        height+=10;
    }
    return height;
}


@end
