//
//  SSClerkDiagnosisResultCustomerCell.m
//  SunSum
//
//  Created by hank on 2019/4/16.
//  Copyright © 2019 hank. All rights reserved.
//

#import "SSClerkDiagnosisResultCustomerCell.h"
#import "AAChartKit.h"
#import "AAChartModel.h"

@interface SSClerkDiagnosisResultCustomerCell ()<AAChartViewDidFinishLoadDelegate>

@property (nonatomic, strong) AAChartModel *aaChartModel;
@property (weak, nonatomic) IBOutlet AAChartView *aaChartView;



@end

@implementation SSClerkDiagnosisResultCustomerCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = 0;
    self.aaChartView.backgroundColor = [UIColor clearColor];
    self.aaChartView.delegate = self;
    self.aaChartView.scrollEnabled = NO;//禁用 AAChartView 滚动效果
    [self.aaChartView aa_drawChartWithChartModel:self.aaChartModel];
    // Initialization code
}

- (void)setUiWithModel:(NSArray *)nowMonth lastMonth:(NSArray*)lastMonth Xtitle:(NSArray*)Xtitle model:(id)model{
//    _aaChartModel.title = kMeUnNilStr(title);
    _aaChartModel.categories = Xtitle;
    self.aaChartModel
    .yAxisTickIntervalSet(@5)
    .yAxisMinSet(@(0))//Y轴最小值
    .colorsThemeSet(@[@"#03D0FB",@"#E37EB8"])
    .seriesSet(@[
                 AASeriesElement.new
                 .nameSet(@"本月")
                 .dataSet(nowMonth),
                 AASeriesElement.new
                 .nameSet(@"上月")
                 .dataSet(lastMonth),
                 ]
               );
    [self.aaChartView aa_refreshChartWithChartModel:self.aaChartModel];
}

- (AAChartModel *)aaChartModel{
    if(!_aaChartModel){
        _aaChartModel= AAChartModel.new
        .yAxisAllowDecimalsSet(NO)//是否允许Y轴坐标值小数
        .chartTypeSet(AAChartTypeColumn)//图表类型
        .titleFontSizeSet(@15)
        .titleSet(@"")//图表主标题
        .subtitleSet(@"")//图表副标题
        .yAxisLineWidthSet(@1)//Y轴轴线线宽为0即是隐藏Y轴轴线
        .colorsThemeSet(@[@"#03D0FB",@"#E37EB8"])
        .easyGradientColorsSet(true)
        .yAxisTitleSet(@"")//设置 Y 轴标题
        .backgroundColorSet(@"#262D4C")
        .yAxisGridLineWidthSet(@1)
        .yAxisLineWidthSet(@1)
        .xAxisLabelsFontColorSet(@"#ffffff")
        .seriesSet(@[
                     AASeriesElement.new
                     .nameSet(@"人数")
                     .dataSet(@[@0,@0])
                     .lineWidthSet(@10),
                     ]
                   );
        //y轴横向分割线宽度为0(即是隐藏分割线)
        _aaChartModel.animationType = AAChartAnimationBounce;//图形的渲染动画为弹性动画
        _aaChartModel.yAxisTitle = @"";
        _aaChartModel.animationDuration = @10;//图形渲染动画时长为1200毫秒
        _aaChartModel.legendEnabled = NO;
        _aaChartModel.tooltipEnabled = NO;
        _aaChartModel.yAxisGridLineWidth =@1;
        _aaChartModel.dataLabelEnabled = YES;
//        _aaChartModel.dataLabelFontColor = @"#818181";
    }
    return _aaChartModel;
}

#pragma mark -- AAChartView delegate
- (void)AAChartViewDidFinishLoad {
    NSLog(@"🔥🔥🔥🔥🔥 AAChartView content did finish load!!!");
}

@end
