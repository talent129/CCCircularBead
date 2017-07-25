//
//  ViewController.m
//  CCCircularBead
//
//  Created by luckyCoderCai on 2017/7/25.
//  Copyright © 2017年 luckyCoderCai. All rights reserved.
//

#import "ViewController.h"

#define kScreen_Height [UIScreen mainScreen].bounds.size.height
#define kScreen_Width [UIScreen mainScreen].bounds.size.width

@interface ViewController ()

@property (nonatomic, strong) UIImageView *carImgView;
@property (nonatomic, strong) UIImageView *dogImgView;
@property (nonatomic, strong) UIImageView *plantImgView;
@property (nonatomic, strong) UIImageView *girlImgView;

@end

@implementation ViewController

#pragma mark -lazy load
- (UIImageView *)carImgView
{
    if (!_carImgView) {
        _carImgView = [[UIImageView alloc] initWithFrame:CGRectMake((kScreen_Width - 80)/2.0, 100, 80, 80)];
        _carImgView.backgroundColor = [UIColor orangeColor];
        _carImgView.image = [UIImage imageNamed:@"car"];
        _carImgView.layer.cornerRadius = 40;
        _carImgView.layer.masksToBounds = YES;
    }
    return _carImgView;
}

- (UIImageView *)dogImgView
{
    if (!_dogImgView) {
        _dogImgView = [[UIImageView alloc] initWithFrame:CGRectMake((kScreen_Width - 80)/2.0, 200, 80, 80)];
//        _dogImgView.backgroundColor = [UIColor orangeColor];
        _dogImgView.image = [UIImage imageNamed:@"dog"];
    }
    return _dogImgView;
}

- (UIImageView *)plantImgView
{
    if (!_plantImgView) {
        _plantImgView = [[UIImageView alloc] initWithFrame:CGRectMake((kScreen_Width - 80)/2.0, 300, 80, 80)];
        _plantImgView.backgroundColor = [UIColor orangeColor];
        _plantImgView.image = [UIImage imageNamed:@"plant"];
    }
    return _plantImgView;
}

- (UIImageView *)girlImgView
{
    if (!_girlImgView) {
        _girlImgView = [[UIImageView alloc] initWithFrame:CGRectMake(5, kScreen_Height - (kScreen_Width - 10) * 281/450.0 - 5, kScreen_Width - 10, (kScreen_Width - 10) * 281/450.0)];
        _girlImgView.backgroundColor = [UIColor orangeColor];
        _girlImgView.image = [UIImage imageNamed:@"girl"];
    }
    return _girlImgView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setupUI];
    
}

#pragma mark -UI
- (void)setupUI
{
    //1.
    [self.view addSubview:self.carImgView];
    
    //2. 使用贝塞尔曲线UIBezierPath和Core Graphics框架画出一个圆角
    [self.view addSubview:self.dogImgView];
    //开始对imageView进行画图
    UIGraphicsBeginImageContextWithOptions(self.dogImgView.bounds.size, NO, 40.0);
    //使用贝塞尔曲线画出一个圆形
    [[UIBezierPath bezierPathWithRoundedRect:self.dogImgView.bounds cornerRadius:self.dogImgView.frame.size.width] addClip];
    [self.dogImgView drawRect:self.dogImgView.bounds];
    self.dogImgView.image = UIGraphicsGetImageFromCurrentImageContext();
    //结束画图
    UIGraphicsEndImageContext();
    
    //3. 使用CAShapeLayer和UIBezierPath设置圆角
    [self.view addSubview:self.plantImgView];
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.plantImgView.bounds byRoundingCorners:UIRectCornerAllCorners cornerRadii:self.plantImgView.bounds.size];
    
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc]init];
    
    //设置大小
    maskLayer.frame = self.plantImgView.bounds;
    
    //设置图形样子
    maskLayer.path = maskPath.CGPath;
    self.plantImgView.layer.mask = maskLayer;
    
    
    //上述第三种使用CAShapeLayer和UIBezierPath设置圆角 byRoundingCorners设置不同枚举和cornerRadii 可以做出一些其他效果
    /*
     typedef NS_OPTIONS(NSUInteger, UIRectCorner) {
     UIRectCornerTopLeft     = 1 << 0,
     UIRectCornerTopRight    = 1 << 1,
     UIRectCornerBottomLeft  = 1 << 2,
     UIRectCornerBottomRight = 1 << 3,
     UIRectCornerAllCorners  = ~0UL
     };
     */
    
    //如 仅视图的上半部分圆角 下半部分仍直角
    [self.view addSubview:self.girlImgView];
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:self.girlImgView.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(10, 10)];
    
    CAShapeLayer *layer = [[CAShapeLayer alloc]init];
    
    //设置大小
    layer.frame = self.girlImgView.bounds;
    
    //设置图形样子
    layer.path = path.CGPath;
    self.girlImgView.layer.mask = layer;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
