//
//  SSClerkWorkDaliyCell.m
//  SunSum
//
//  Created by hank on 2019/4/13.
//  Copyright © 2019 hank. All rights reserved.
//

#import "SSClerkWorkDaliyCell.h"
#import "AAChartKit.h"
#import "AAChartModel.h"

@interface SSClerkWorkDaliyCell ()<AAChartViewDidFinishLoadDelegate>

@property (nonatomic, strong) AAChartModel *aaChartModel;
@property (weak, nonatomic) IBOutlet AAChartView *aaChartView;
@property (weak, nonatomic) IBOutlet UILabel *lblProgress;


@end


@implementation SSClerkWorkDaliyCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = 0;
    self.aaChartView.backgroundColor = [UIColor whiteColor];
    self.aaChartView.delegate = self;
    self.aaChartView.scrollEnabled = NO;//禁用 AAChartView 滚动效果
    [self.aaChartView aa_drawChartWithChartModel:self.aaChartModel];
}

- (void)setUiWithModel:(NSArray *)model Xtitle:(NSArray*)Xtitle title:(NSString *)title progress:(NSString*)progress{
    _lblProgress.text = kMeUnNilStr(progress);
    self.aaChartModel.title = kMeUnNilStr(title);
    //    NSArray *arrSex = @[@"女",@"男",@"保密"];
    NSMutableArray *arr = [NSMutableArray array];
    for (NSInteger i=0; i<model.count; i++) {
        [arr addObject:@[kMeUnNilStr(Xtitle[i]),model[i]]];
    }
    self.aaChartModel.series =
    @[
      AASeriesElement.new
      .nameSet(@"人数")
      .innerSizeSet(@"0%")//内部圆环半径大小占比
      .statesSet(@{@"hover": @{@"enabled": @(false)}})
      .sizeSet(@124)//尺寸大小
      .borderWidthSet(@0)//描边的宽度
      .allowPointSelectSet(false)//是否允许在点击数据点标记(扇形图点击选中的块发生位移)
      .dataSet(arr),
      ];
    [self.aaChartView aa_refreshChartWithChartModel:self.aaChartModel];
}

- (AAChartModel *)aaChartModel{
    if(!_aaChartModel){
        _aaChartModel = AAChartModel.new
        .chartTypeSet(AAChartTypePie)
        .titleFontSizeSet(@15)
        .colorsThemeSet(@[@"#7C68FF",@"#728DFF",@"#E070FF",@"#FEB662"])
        .titleSet(@"")
        .subtitleSet(@"")
        .dataLabelEnabledSet(true)//是否直接显示扇形图数据
        .yAxisTitleSet(@"")
        ;
        _aaChartModel.categories = @[@"",@"",@"",@""];
    }
    
    return _aaChartModel;
}


#pragma mark -- AAChartView delegate
- (void)AAChartViewDidFinishLoad {
    NSLog(@"🔥🔥🔥🔥🔥 AAChartView content did finish load!!!");
}
@end
