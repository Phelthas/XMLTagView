//
//  XMLTagView.m
//  XMLTagViewDemo
//
//  Created by luxiaoming on 15/2/12.
//  Copyright (c) 2015年 luxiaoming. All rights reserved.
//

#import "XMLTagView.h"
#import <PureLayout.h>

@interface XMLTagView ()

@property (nonatomic, assign) NSInteger tagButtonCount;


@end

@implementation XMLTagView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.preferredMaxLayoutWidth = CGRectGetWidth(frame);
        self.interitemSpacing = 10;
        self.lineSpacing = 10;
        self.edgeInsets = UIEdgeInsetsMake(10, 10, 10, 10);
        
    }
    return self;
}

#pragma mark - publicMethod

- (void)reloadData {
    for (UIView *subView in self.subviews) {
        [subView removeFromSuperview];
    }
    self.tagButtonCount = [self.delegate numberOfTagButton];
    UIButton *previousButton = nil;
    CGFloat currentX = self.edgeInsets.left;
    CGFloat currentY = self.edgeInsets.top;
    CGFloat rowHeight = 0;
    for (NSInteger i = 0; i < self.tagButtonCount; i++) {
        UIButton *button = [self.delegate tagButtonAtIndex:i];
        button.tag = i;
        [button addTarget:self action:@selector(handleTagButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
        CGFloat buttonWidth = button.intrinsicContentSize.width;
        [self addSubview:button];
        
        //这一句效果是：tagButton的宽度最大是占满一行，如果放不下，会优先放到下一行，再换行
        CGFloat tagButtonMaxWidth = self.preferredMaxLayoutWidth - self.edgeInsets.left - self.edgeInsets.right;//最大宽度-tagView距离屏幕的左右距离
        [button autoSetDimension:ALDimensionWidth toSize:tagButtonMaxWidth relation:NSLayoutRelationLessThanOrEqual];
        
        UILabel *label = button.titleLabel;
        
        CGFloat realHeight = [label.text sizeWithFont:label.font constrainedToSize:CGSizeMake(tagButtonMaxWidth - button.contentEdgeInsets.left - button.contentEdgeInsets.right, CGFLOAT_MAX)].height;//最大宽度-tagView距离屏幕的左右距离-button文字距离button的距离
        realHeight += button.contentEdgeInsets.top + button.contentEdgeInsets.bottom;
        
        [button autoSetDimension:ALDimensionHeight toSize:realHeight relation:NSLayoutRelationEqual];

        if (!previousButton) {
            //是第一个tagButton
            [button autoPinEdgeToSuperviewEdge:ALEdgeLeading withInset:self.edgeInsets.left];
            [button autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:self.edgeInsets.top];
            
        } else {
            //已经有前一个button
            if (currentX + buttonWidth + self.edgeInsets.right < self.preferredMaxLayoutWidth) {
                //如果这一行还放的下
                [button autoConstrainAttribute:ALAttributeTop toAttribute:ALAttributeTop ofView:previousButton];
                [button autoPinEdge:ALEdgeLeading toEdge:ALEdgeTrailing ofView:previousButton withOffset:self.interitemSpacing];
            } else {
                currentY += rowHeight + self.lineSpacing;
                [button autoPinEdgeToSuperviewEdge:ALEdgeLeading withInset:self.edgeInsets.left];
                [button autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:currentY];
                rowHeight = 0;
                currentX = self.edgeInsets.left;
            }
            
        }

        previousButton = button;
        currentX += previousButton.intrinsicContentSize.width + self.interitemSpacing;
        
        if (rowHeight < realHeight) {
            rowHeight = realHeight;
        }
        
        if (i == self.tagButtonCount - 1) {
            [button autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:10 relation:NSLayoutRelationGreaterThanOrEqual];
        }
    }

}

#pragma mark - buttonAction

- (void)handleTagButtonTapped:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(tagView:didSelectButtonAtIndex:)]) {
        [self.delegate tagView:self didSelectButtonAtIndex:sender.tag];
    }
}




@end
