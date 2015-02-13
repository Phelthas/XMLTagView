//
//  ViewController.m
//  XMLTagViewDemo
//
//  Created by luxiaoming on 15/2/13.
//  Copyright (c) 2015年 luxiaoming. All rights reserved.
//

#import "ViewController.h"
#import "XMLTagView.h"
#import <PureLayout.h>

@interface ViewController ()<XMLTagViewDelegate>

@property (nonatomic, strong) XMLTagView *tagView;
@property (nonatomic, strong) NSArray *tagTitleArray;

@property (nonatomic, assign) NSInteger initStyle;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.initStyle = 1;
    
    switch (self.initStyle) {
        case 1: {
            //初始化方式1,没有用autoLayout的view可以直接初始化frame，add到父View上去
            XMLTagView *tagView = [[XMLTagView alloc] initWithFrame:CGRectMake(10, 20, 280, 500)];
            tagView.backgroundColor = [UIColor lightGrayColor];
            tagView.delegate = self;
            [self.view addSubview:tagView];
            self.tagView = tagView;
        }
            break;
        case 2: {
            //初始化方式2，使用了autoLayout的view，需要设置tagView的preferredMaxLayoutWidth
            XMLTagView *tagView = [[XMLTagView alloc] init];
            tagView.backgroundColor = [UIColor lightGrayColor];
            tagView.preferredMaxLayoutWidth = 280;//preferredMaxLayoutWidth一般来说应该设置成TagView的最终宽度
            tagView.delegate = self;
            [self.view addSubview:tagView];
            self.tagView = tagView;
            [self.tagView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(10, 10, 10, 30)];
        }
            break;
        default:
            break;
    }
    
    [self.tagView reloadData];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    if (self.initStyle == 1) {
        //如果想得到tagView最低的高度，请使用如下方法
        CGFloat realHeight = [self.tagView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
        CGRect frame = self.tagView.frame;
        frame.size.height = realHeight;
        self.tagView.frame = frame;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - privateMethod

- (UIButton *)createDefaultTagButton {
    UIButton *button = [[UIButton alloc] init];
    //    [button setTranslatesAutoresizingMaskIntoConstraints:NO];这一句不用写，因为用pureLayout的时候它帮我们写了
    button.titleLabel.numberOfLines = 0;
    button.titleLabel.lineBreakMode = NSLineBreakByCharWrapping;
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button setBackgroundColor:[UIColor orangeColor]];
    button.titleLabel.font = [UIFont systemFontOfSize:14];
    button.layer.cornerRadius = 5;
    button.layer.masksToBounds = YES;
    return button;
}

#pragma mark - XMLTagViewDelegate

- (NSInteger)numberOfTagButton {
    return self.tagTitleArray.count;
}

- (UIButton *)tagButtonAtIndex:(NSInteger)index {
    UIButton *button = [self createDefaultTagButton];
    NSString *title = self.tagTitleArray[index];
    [button setTitle:title forState:UIControlStateNormal];
    return button;
}

- (void)tagView:(XMLTagView *)tagView didSelectButtonAtIndex:(NSInteger)index {
    NSLog(@"didSelectButtonAtIndex %ld",(long)index);
}

#pragma mark - property

- (NSArray *)tagTitleArray {
    if (!_tagTitleArray) {
        _tagTitleArray = @[@"one1", @"twotwo2", @"twotwotwotwotwwo3", @"twotwotwotwotwotwotwtwotwotwotwotwotwotwotwotwootwotwotwotwotwotwotwotwotwotwotwotwotwtwotwotwotwotwotwotwotwtwotwtwotwotwotwotwotwotwotwotwootwotwotwotwotwotwotwotwotwotwotwotwotwotwotwotwotwotwotwo444", @"twotwotwotwotwotwotwotwotwotwotwotwotwotwo555", @"twotwotwotwotwotwo66", @"wotwotwo77", @"twottwotwotwotwotwotwotwotwotwowotwotwotwotwotwotwotwo88", @"two99", @"twotwotwtwotwotwotwotwotwotwotwotwootwotwotwotwotwotwotwotwotwotwo10"];
        
    }
    return _tagTitleArray;
}
@end
