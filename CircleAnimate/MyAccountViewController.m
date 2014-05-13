//
//  MyAccountViewController.m
//  zhuna2.0
//
//  Created by zhuna on 14-5-8.
//  Copyright (c) 2014年 zhuna. All rights reserved.
//

#import "MyAccountViewController.h"
#import <CoreGraphics/CGContext.h>


@interface MyAccountViewController ()
{
    CAShapeLayer * arcLayer;
    UIView * circleViewCashBack;
    UIView * circleViewGetCash;
}
@property(nonatomic, retain)UILabel* beatLabel;

@end

@implementation MyAccountViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.view setBackgroundColor:[UIColor grayColor]];
    [self initPercentageView];
    
    [self initFanShapeCashBack];
}

-(void)initPercentageView
{
    UIView * percentageView = [[UIView alloc] initWithFrame:CGRectMake(15, 20+9+44+9+107, 290, 260)];
    [percentageView setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:percentageView];
    
    self.beatLabel = [[UILabel alloc] initWithFrame:CGRectMake(282/2-20, 146/2+20, 150, 35)];
    [percentageView addSubview:self.beatLabel];
    [self.beatLabel setFont:[UIFont systemFontOfSize:14]];
    [self.beatLabel setBackgroundColor:[UIColor clearColor]];
    NSString *str2 = @"abcdefghijk";
    [self.beatLabel setText:str2];
    
    NSMutableAttributedString *attrStr2 = [[NSMutableAttributedString alloc] initWithString:str2];
    [attrStr2 addAttribute:NSForegroundColorAttributeName
                    value:[UIColor greenColor]
                    range:NSMakeRange(0, 3)];
    [attrStr2 addAttribute:NSForegroundColorAttributeName
                    value:[UIColor yellowColor]
                    range:NSMakeRange(3, 3)];
    [attrStr2 addAttribute:NSFontAttributeName
                     value:[UIFont boldSystemFontOfSize:30.0f]
                     range:NSMakeRange(6, 5)];
    
    [self.beatLabel setAttributedText:attrStr2];

    UIImageView *imageView1 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 292/2+5, 290, 2)];
    [percentageView addSubview:imageView1];
    
    UIGraphicsBeginImageContext(imageView1.frame.size);
    [imageView1.image drawInRect:CGRectMake(0, 0, imageView1.frame.size.width, imageView1.frame.size.height)];
    CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound);

    float lengths[] = {3,3};
    CGContextRef line = UIGraphicsGetCurrentContext();
    CGContextSetStrokeColorWithColor(line, [UIColor grayColor].CGColor);
    
    CGContextSetLineDash(line, 0, lengths, 2);
    CGContextMoveToPoint(line, 10.0, 1.0);
    CGContextAddLineToPoint(line, 280.0, 1.0);
    CGContextStrokePath(line);
    imageView1.image = UIGraphicsGetImageFromCurrentImageContext();
    
    circleViewCashBack = [[UIView alloc] initWithFrame:CGRectMake(38/2, 46/2+32, 92, 92)];
    [percentageView addSubview:circleViewCashBack];
    [circleViewCashBack setBackgroundColor:[UIColor clearColor]];

    circleViewGetCash = [[UIView alloc] initWithFrame:CGRectMake(38/2, 314/2, 92, 92)];
    [percentageView addSubview:circleViewGetCash];
    [circleViewGetCash setBackgroundColor:[UIColor clearColor]];
}

-(void)initFanShapeCashBack
{
    CGRect rect=circleViewCashBack.frame;
    CGRect layerRect = CGRectMake(0, 0, 92, 92);

    UIBezierPath *path=[UIBezierPath   bezierPathWithArcCenter:CGPointMake(rect.size.width/2,rect.size.height/2)
                                                         radius:46
                                                     startAngle:0
                                                       endAngle:2*M_PI
                                                      clockwise:YES];
    
    arcLayer=[CAShapeLayer layer];
    arcLayer.path=path.CGPath;//46,169,230
    arcLayer.fillColor=[UIColor yellowColor].CGColor;
    arcLayer.strokeColor=[UIColor colorWithWhite:1 alpha:0.7].CGColor;
    arcLayer.lineWidth=0;
    arcLayer.frame=layerRect;
    [circleViewCashBack.layer addSublayer:arcLayer];
    
    UIBezierPath *path2=[UIBezierPath bezierPath];
    [path2 addArcWithCenter:CGPointMake(rect.size.width/2,rect.size.height/2) radius:28 startAngle:-M_PI_2 endAngle:0 clockwise:YES];
    arcLayer=[CAShapeLayer layer];
    arcLayer.path=path2.CGPath;//46,169,230
    arcLayer.fillColor=[UIColor clearColor].CGColor;
    arcLayer.strokeColor=[UIColor redColor].CGColor;
    arcLayer.lineWidth=30;
    arcLayer.frame=layerRect;
    [circleViewCashBack.layer addSublayer:arcLayer];
    [self fanShapeAnimation:arcLayer];
    
    UIBezierPath *path1=[UIBezierPath   bezierPathWithArcCenter:CGPointMake(rect.size.width/2,rect.size.height/2)
                                                          radius:14
                                                      startAngle:0
                                                        endAngle:2*M_PI
                                                       clockwise:YES];
    
    arcLayer=[CAShapeLayer layer];
    arcLayer.path=path1.CGPath;//46,169,230
    arcLayer.fillColor=[UIColor whiteColor].CGColor;
    arcLayer.strokeColor=[UIColor greenColor].CGColor;
    arcLayer.lineWidth=2;
    arcLayer.frame=layerRect;
    [circleViewCashBack.layer addSublayer:arcLayer];

}


-(void)fanShapeAnimation:(CALayer*)layer
{
    CABasicAnimation *bas=[CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    bas.duration=1;
    bas.delegate=self;
    bas.fromValue=[NSNumber numberWithInteger:0];
    bas.toValue=[NSNumber numberWithInteger:1];
    [layer addAnimation:bas forKey:@"key"];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
