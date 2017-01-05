//
//  DDMMenuView.m
//  dropDownMenu
//
//  Created by wujin on 2016/10/23.
//  Copyright © 2016年 Individual Developer. All rights reserved.
//

#import "DDMMenuView.h"
#import "UIConstants.h"
#import "DDMCollectionViewCell.h"

// 按钮 y
#define buttonGroupY 0
// 按钮 height
#define buttonGroupHeight 45
// collectionView y
#define collectionViewY buttonGroupY+buttonGroupHeight

@interface DDMMenuView ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UIGestureRecognizerDelegate>

@property NSMutableArray<UIButton *> *btnsArray;
@property int heightOfCollectionView;
@property int selectedButtonNum;
@property (nonatomic,strong) UICollectionView *collectionView;
@property (nonatomic, strong) UIView *subView;
@property (nonatomic, strong) NSArray *cellArray;
@property (nonatomic, strong) UIView *viewLine;
@property (nonatomic, strong) UITapGestureRecognizer* singleTap;
@property (nonatomic, strong) NSArray <NSArray *> *collectionDataArray;
@property (nonatomic, strong) NSArray <NSArray *> *titleDataArray;
@property (nonatomic, assign) DDMMenuStyle menuStyle;
@property (nonatomic, strong) UIColor *cellColorOfYourself;
@property (nonatomic, assign) Boolean hasBolderYourself;

@end

@implementation DDMMenuView

- (instancetype)initWithFrame:(CGRect)frame menuData:(NSArray<NSArray *> *)menuData titleData:(NSArray *)titleData menuStyle:(DDMMenuStyle)menuStyle{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        // 初始化被选择的按钮
        _selectedButtonNum = -1;
        // 初始化每个Cell的数据
        _cellArray = [[NSArray alloc] init];
        
        // 初始化数据
        _collectionDataArray = menuData;
        _titleDataArray = titleData;
        _menuStyle = menuStyle;
        
        [self subView];
        [self addSubview:_subView];
        
        [self buttonsTop];
        for (int i=0; i<_btnsArray.count; i++) {
            [self addSubview:_btnsArray[i]];
        }
        
        [self collectionView];
        [self addSubview:_collectionView];
        
        [self viewLine];
        [self addSubview:_viewLine];
        
        //添加手势
        [self singleTap];
        [self addGestureRecognizer:_singleTap];
    }
    return self;
}

- (UIView *)viewLine{
    if (!_viewLine) {
        _viewLine = [[UIView alloc] initWithFrame:CGRectMake(0, buttonGroupHeight+buttonGroupY-1, SCREEN_WIDTH, 1)];
        _viewLine.backgroundColor = AppLineColor;
    }
    return _viewLine;
}
- (UIView *)subView{
    if (!_subView) {
        _subView = [[UIView alloc] initWithFrame:CGRectMake(0, collectionViewY, SCREEN_WIDTH, 0)];
        _subView.backgroundColor = [UIColor lightGrayColor];
        _subView.alpha = 0.5;
    }
    return _subView;
}

-(void)buttonsTop{
    _btnsArray = [[NSMutableArray alloc] init];
    NSArray *btnTitle = @[_titleDataArray[0],_titleDataArray[1],_titleDataArray[2],_titleDataArray[3]];
    for (int i = 0; i<4; i++) {
        _btnsArray[i]=[UIButton buttonWithType:UIButtonTypeSystem];
        [_btnsArray[i] addTarget:self action:@selector(onClickBtns:) forControlEvents:UIControlEventTouchUpInside];
        [_btnsArray[i] setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [_btnsArray[i] setTitle:btnTitle[i] forState:UIControlStateNormal];
        _btnsArray[i].frame = CGRectMake(i*SCREEN_WIDTH/4, buttonGroupY, SCREEN_WIDTH/4, buttonGroupHeight);
        _btnsArray[i].layer.borderColor = [UIColor clearColor].CGColor;
        _btnsArray[i].layer.borderWidth = 1;
        _btnsArray[i].backgroundColor = [UIColor whiteColor];
        _btnsArray[i].tag = i;
    }
}

- (UICollectionView *)collectionView{
    if(!_collectionView){
        // 创建UICollectionView
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
        // 头部大小
        flowLayout.headerReferenceSize = CGSizeMake(SCREEN_WIDTH, 5);
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0,collectionViewY,SCREEN_WIDTH,0) collectionViewLayout:flowLayout];
        // 每个UICollectionView大小
        flowLayout.itemSize = CGSizeMake((SCREEN_WIDTH-30)/4, 35);
        // 横向间距
        flowLayout.minimumInteritemSpacing = 5;
        // 纵向间距
        flowLayout.minimumLineSpacing = 5;
        // 上左下右
        flowLayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
        
        [_collectionView registerClass:[DDMCollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
        
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.allowsMultipleSelection = NO;
        
        _collectionView.autoresizingMask = UIViewAutoresizingFlexibleWidth |UIViewAutoresizingFlexibleHeight;
    }
    return _collectionView;
}

// 单击手势
- (UITapGestureRecognizer*)singleTap{
    if (!_singleTap){
        _singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap:)];
        _singleTap.delegate = self;
        _singleTap.cancelsTouchesInView = NO;
    }
    return _singleTap;
}

-(void)onClickBtns:(id)sender{
    UIButton *button = (UIButton *)sender;
    if(_btnsArray[button.tag].titleLabel.textColor== [UIColor lightGrayColor]){
        // 被选中
        _selectedButtonNum = (int)button.tag;
        for (int i=0; i<_btnsArray.count; i++) {
            [_btnsArray[i] setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        }
        [_btnsArray[button.tag] setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        // 移入collectionView
        [self moveInCollectionViewWhenSelected:_collectionDataArray[_selectedButtonNum]];
        
    }else{
        // 不被选中
        [_btnsArray[button.tag] setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        // 移出CollectionView
        [self moveCollectionView];
    }
}

#pragma mark collection view delegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _cellArray.count;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identify = @"cell";
    DDMCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identify forIndexPath:indexPath];
    [cell sizeToFit];
    for (NSUInteger i = 0; i< _cellArray.count; i++) {
        if (indexPath.row == i) {
            cell.cellLabel.text = _cellArray[i];
        }
    }
    NSString *buttonText = [[NSString alloc] init];
    buttonText = _btnsArray[_selectedButtonNum].currentTitle;
    if([cell.cellLabel.text isEqualToString: buttonText]){
        // 1
        // cell.cellLabel.backgroundColor = [UIColor redColor];
        [self LoadMenuStyle:cell];
    }else{
        // 2
        [self moveOutMenuStyle:cell];
    }
    
    //cell.timeLabel.text = [NSString stringWithFormat:@"Cell %ld",indexPath.item];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    // 除了被选择的cell，其余的都去除样式
    for(DDMCollectionViewCell *cell in collectionView.visibleCells){
        [self moveOutMenuStyle:cell];
    }
    
    // 加载被选择的cell样式
    DDMCollectionViewCell * cell = (DDMCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    // 3
    // cell.cellLabel.backgroundColor = [UIColor redColor];
    [self LoadMenuStyle:cell];
    
    [_btnsArray[_selectedButtonNum] setTitle:cell.cellLabel.text forState:UIControlStateNormal];
}

// 去除所有Cell的样式
-(void)moveOutMenuStyle:(DDMCollectionViewCell *)cell{
    cell.cellLabel.backgroundColor = [UIColor whiteColor];
    cell.cellLabel.layer.borderWidth = 0;
    cell.cellLabel.layer.borderColor = [UIColor clearColor].CGColor;
}

// 加载被选择的cell的样式
-(void)LoadMenuStyle:(DDMCollectionViewCell *)cell{
    if (_menuStyle == DDMMenuStyleDefault){
        cell.cellLabel.backgroundColor = [UIColor lightGrayColor];
        cell.cellLabel.layer.cornerRadius = 12;
    }else if(_menuStyle == DDMMenuStyleLighterGray){
        cell.cellLabel.backgroundColor = [UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:1];
        cell.cellLabel.layer.cornerRadius = 12;
    }else if(_menuStyle == DDMMenuStyleWithBorder){
        cell.cellLabel.backgroundColor = [UIColor whiteColor];
        cell.cellLabel.layer.borderWidth = 1;
        cell.cellLabel.layer.borderColor = [UIColor lightGrayColor].CGColor;
        cell.cellLabel.layer.cornerRadius = 12;
    }else if(_menuStyle == DDMMenuStyleOfSquareBorder){
        cell.cellLabel.backgroundColor = [UIColor whiteColor];
        cell.cellLabel.layer.borderWidth = 1;
        cell.cellLabel.layer.borderColor = [UIColor lightGrayColor].CGColor;
        cell.cellLabel.layer.cornerRadius = 8;
    }else if(_menuStyle == DDMMenuStyleOfYourself){
        if(!_hasBolderYourself||!_cellColorOfYourself||_cellColorOfYourself == [UIColor clearColor]){
            NSLog(@"请设置样式，调用-(void)initCellStyleOfYourself:(Boolean)hasBorder cellColor:(UIColor *)cellColor方法");
            NSLog(@"Please set the style,use'-(void)initCellStyleOfYourself:(Boolean)hasBorder cellColor:(UIColor *)cellColor方法'");
            cell.cellLabel.backgroundColor = [UIColor lightGrayColor];
            cell.cellLabel.layer.cornerRadius = 12;
            return;
        }
        cell.cellLabel.backgroundColor = _cellColorOfYourself;
        if(_hasBolderYourself){
            cell.cellLabel.layer.borderWidth = 1;
            cell.cellLabel.layer.borderColor = [UIColor lightGrayColor].CGColor;
            cell.cellLabel.layer.cornerRadius = 12;
        }
    }
}

- (void)initCellStyleOfYourself:(Boolean)hasBorder cellColor:(UIColor *)cellColor{
    if(_menuStyle == DDMMenuStyleOfYourself){
        if(!hasBorder||!cellColor||cellColor == [UIColor clearColor]){
            return;
        }else{
            _cellColorOfYourself = cellColor;
            _hasBolderYourself = hasBorder;
        }
    }
    //    else{
    //        NSLog(@"请设置样式，调用-(void)initCellStyleOfYourself:(Boolean)hasBorder cellColor:(UIColor *)cellColor方法");
    //        NSLog(@"Please set the style,use'调用-(void)initCellStyleOfYourself:(Boolean)hasBorder cellColor:(UIColor *)cellColor方法'");
    //        return;
    //    }
}

// 移入collectionView
-(void)moveInCollectionViewWhenSelected:(NSArray *)array{
    _cellArray = array;
    if(_cellArray.count%4 != 0){
        _heightOfCollectionView =  [NSNumber numberWithUnsignedLong: 40*(_cellArray.count/4+1)+5].intValue;
    }else{
        _heightOfCollectionView =  [NSNumber numberWithUnsignedLong: 40*(_cellArray.count/4)+5].intValue;
    }
    
    [self.collectionView reloadData];
    // 显示背景灰色
    [self showSubView_y:collectionViewY height:SCREEN_HEIGHT-collectionViewY];
    [UIView animateWithDuration:0.5 animations:^{
        if (self.collectionView) {
            self.collectionView.frame = CGRectMake(0, collectionViewY, SCREEN_WIDTH, _heightOfCollectionView);
        }
    }];
}

// 显示背景灰色
-(void)showSubView_y:(int)y height:(int)height{
    _subView.frame = CGRectMake(0, y, SCREEN_WIDTH, height);
}
// 去除背景灰色
-(void)moveOutSubView{
    _subView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 0);
}

// 单击手势触发
-(void)handleSingleTap:(UITapGestureRecognizer *)sender{
    CGPoint point = [sender locationInView:self];
    
    // 当collectionView显示时，点击空白处
    if(self.collectionView.frame.size.height!=0){
        if(point.y > _heightOfCollectionView+collectionViewY){
            [self moveCollectionView];
        }
    }
}

// 移出CollectionView
-(void)moveCollectionView{
    for(int i=0; i<_btnsArray.count; i++){
        [_btnsArray[i] setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    }
    [self moveOutSubView];
    [UIView animateWithDuration:0.5 animations:^{
        if (self.collectionView) {
            self.collectionView.frame = CGRectMake(0, collectionViewY, SCREEN_WIDTH, 0);
        }
    }];
    // 选择下拉菜单数据后点击空白或按钮确认
    if(self.delegate!=nil){
        [self.delegate chooseCellAndDoWhatYouWishWithButtonZeroth:_btnsArray[0].currentTitle
                                                      ButtonFirst:_btnsArray[1].currentTitle
                                                     ButtonSecond:_btnsArray[2].currentTitle
                                                      ButtonThird:_btnsArray[3].currentTitle];
    }
}

// returning YES is guaranteed to allow simultaneous recognition
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer{
    return YES;
}

@end
