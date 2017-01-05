//
//  DDMViewController.m
//  dropDownMenu
//
//  Created by wujin on 2016/10/23.
//  Copyright © 2016年 Individual Developer. All rights reserved.
//

#import "DDMViewController.h"
#import "DDMMenuView.h"
#import "UIConstants.h"

@interface DDMViewController ()<DDMMenuViewDelegate>

@property (nonatomic, strong) DDMMenuView *menuView;

@property (nonatomic, strong) NSArray *titleData;

@property (nonatomic, strong) UILabel *navigationLabel;

@end

@implementation DDMViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //self.view.backgroundColor = [UIColor whiteColor];
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    // Bar的模糊效果 默认为YES iOS7及以上对导航栏（工具栏亦同）有高斯模糊处理
    self.navigationController.navigationBar.translucent = NO;
    
    // navigation顶部title
    [self setNavigationLabelTitle:@"TropDownMenu"];
    
    // 初始化数据
    [self initData];
    
    // 加载View
    _menuView = [[DDMMenuView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-NAV_BAR_HEIGHT) menuData:_collectionDataArray titleData:_titleData menuStyle:DDMMenuStyleWithBorder];
    _menuView.delegate = self;
    [self.view addSubview:_menuView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


// 初始化数据
-(void) initData{
    // 初始化下拉菜单数据
    _collectionDataArray = @[@[@"FRUITS",@"appple",@"banana",@"pear",@"pitch",@"grape",@"pineapple",@"strawberry",@"cherry",@"grapefruit",@"orange",@"lemon",@"apricot"],@[@"PROGRAM",@"Java",@"Javascript",@"Swift",@"Object-c",@"Python",@"AngularJs",@"Html",@"PHP",@"C",@"C++",@"C#"],@[@"VEGETABLE",@"cabbage",@"lettuce",@"carrot",@"spinach",@"radish",@"cauliflower",@"chili",@"pepper",@"scallion",@"garlic",@"laver",@"kelp",@"mushroom",@"buds"],@[@"NUMBERS",@"3.1415",@"0011",@"9.8",@"0X00",@"e",@"1314",@"log6",@"1^3",@"9!"]];
    // 初始化下拉菜单Title数据
    _titleData = @[@"FRUITS",@"PROGRAM",@"VEGETABLE",@"NUMBERS"];
}

/**
 *  选择下拉菜单数据后点击空白或按钮确认
 
 */
-(void)chooseCellAndDoWhatYouWishWithButtonZeroth:(NSString *)buttonZeroth
                                      ButtonFirst:(NSString *)buttonFirst
                                     ButtonSecond:(NSString *)buttonSecond
                                      ButtonThird:(NSString *)buttonThird{
    NSLog(@"Your choise:%@ %@ %@ %@",buttonZeroth,buttonFirst,buttonSecond,buttonThird);
}

/**
 *  设置NavigationLabel
 *
 *  @param title title
 */
-(void)setNavigationLabelTitle:(NSString *)title{
    self.navigationLabel.text = title;
}

-(UILabel *)navigationLabel{
    if(!_navigationLabel){
        _navigationLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 100, 100, 20)];
        _navigationLabel.font = [UIFont systemFontOfSize:18];
        _navigationLabel.textAlignment = NSTextAlignmentCenter;
        _navigationLabel.textColor = [UIColor blackColor];
        self.navigationItem.titleView = _navigationLabel;
        
    }
    return _navigationLabel;
}

@end
