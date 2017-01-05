//
//  DDMMenuView.h
//  dropDownMenu
//
//  Created by wujin on 2016/10/23.
//  Copyright © 2016年 Individual Developer. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 选择下拉框样式
 
 - DDMMenuStyleDefault:     默认样式
 - DDMMenuStyleLighterGray: 浅灰色
 - DDMMenuStyleWithLayer:   加边框的样式
 - DDMMenuStyleWithLayer:   加方形边框的样式
 */
typedef NS_ENUM(NSInteger, DDMMenuStyle) {
    DDMMenuStyleDefault,
    DDMMenuStyleLighterGray,
    DDMMenuStyleWithBorder,
    DDMMenuStyleOfSquareBorder,
    DDMMenuStyleOfYourself
};

@protocol DDMMenuViewDelegate
/**
 选择下拉菜单数据后点击空白或按钮确认

 @param buttonZeroth buttonZeroth
 @param buttonFirst  buttonFirst
 @param buttonSecond buttonSecond
 @param buttonThird  buttonThird
 */
@required
-(void)chooseCellAndDoWhatYouWishWithButtonZeroth:(NSString *)buttonZeroth
                                      ButtonFirst:(NSString *)buttonFirst
                                     ButtonSecond:(NSString *)buttonSecond
                                      ButtonThird:(NSString *)buttonThird;

@end

@interface DDMMenuView : UIView

@property (nonatomic, strong) NSMutableArray *tbData;

@property (nonatomic,assign) id<DDMMenuViewDelegate> delegate;

/**
 初始化Menu

 @param frame     frame
 @param menuData  下拉菜单数据
 @param titleData 下拉菜单标题数据
 @param menuStyle 下拉菜单风格

 @return <#return value description#>
 */
- (instancetype)initWithFrame:(CGRect)frame menuData:(NSArray<NSArray *> *)menuData titleData:(NSArray *)titleData menuStyle:(DDMMenuStyle)menuStyle;

/**
 如果设置下拉菜单风格为自定义 则调用此方法

 @param hasBorder 是否有边框
 @param cellColor 下拉菜单按钮颜色
 */
- (void)initCellStyleOfYourself:(Boolean)hasBorder cellColor:(UIColor *)cellColor;

@end
