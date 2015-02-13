//
//  XMLTagView.h
//  TEST_PureLayout
//
//  Created by luxiaoming on 15/2/12.
//  Copyright (c) 2015年 luxiaoming. All rights reserved.
//

#import <UIKit/UIKit.h>

@class XMLTagView;

@protocol XMLTagViewDelegate <NSObject>

@required

- (NSInteger)numberOfTagButton;


/**
 *  要显示的tagButton，不用设置frame，注意：内部使用了button.tag，所以外部不能再设置button的tag
 *
 *  @param index <#index description#>
 *
 *  @return <#return value description#>
 */
- (UIButton *)tagButtonAtIndex:(NSInteger)index;

@optional

- (void)tagView:(XMLTagView *)tagView didSelectButtonAtIndex:(NSInteger)index;

@end



@interface XMLTagView : UIView

@property (nonatomic, assign) CGFloat interitemSpacing;//default is 10;
@property (nonatomic, assign) CGFloat lineSpacing;//default is 10;
@property (nonatomic, assign) UIEdgeInsets edgeInsets;//default is (10, 10, 10, 10);

@property (nonatomic, assign) id<XMLTagViewDelegate> delegate;

/**
 *  如果tagView没有设置frame，那必须要设置此属性，否则无法确定tagView的最大宽度
 *  如果设置了frame，也设置了此属性，会以此属性为准
 */
@property (nonatomic, assign) CGFloat preferredMaxLayoutWidth;

- (void)reloadData;


@end
