//
//  MWCaptionView.m
//  MWPhotoBrowser
//
//  Created by Michael Waterfall on 30/12/2011.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "MWCommon.h"
#import "MWCaptionView.h"
#import "MWPhoto.h"

static const CGFloat labelPadding = 10;

// Private
@interface MWCaptionView ()<UITextViewDelegate>
{
    id <MWPhoto> _photo;
}
@end

@implementation MWCaptionView

- (id)initWithPhoto:(id<MWPhoto>)photo andShowTextView:(BOOL)showTextView
{
    self.showTextView = showTextView;
    self = [self initWithPhoto:photo];
    if (self)
    {
        return self;
    }
    return self;
}
- (id)initWithPhoto:(id<MWPhoto>)photo {
    self = [super initWithFrame:CGRectMake(0, 0, 320, 44)]; // Random initial frame
    if (self) {
        self.userInteractionEnabled = YES;
        _photo = photo;
        self.barStyle = UIBarStyleBlackTranslucent;
        self.tintColor = nil;
        self.barTintColor = nil;
        [self setBackgroundImage:nil forToolbarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
        self.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleRightMargin;
        [self setupCaption];
    }
    return self;
}

- (CGSize)sizeThatFits:(CGSize)size
{
    if (self.showTextView == NO)
    {
        CGFloat maxHeight = 9999;
        if (_label.numberOfLines > 0) maxHeight = _label.font.leading*_label.numberOfLines;
        CGSize textSize = [_label.text boundingRectWithSize:CGSizeMake(size.width - labelPadding*2, maxHeight)
                                                    options:NSStringDrawingUsesLineFragmentOrigin
                                                 attributes:@{NSFontAttributeName:_label.font}
                                                    context:nil].size;
        return CGSizeMake(size.width, textSize.height + labelPadding * 2);
    }
    else
    {
        CGFloat maxHeight = 150;
//        if (_label.numberOfLines > 0)
//            maxHeight = _label.font.leading*_label.numberOfLines;
        CGSize textSize = [_textView.text boundingRectWithSize:CGSizeMake(size.width - labelPadding*2, maxHeight)
                                                    options:NSStringDrawingUsesLineFragmentOrigin
                                                 attributes:@{NSFontAttributeName:_textView.font}
                                                    context:nil].size;
        if (textSize.height > 150)
        {
            _textView.frame = CGRectIntegral(CGRectMake(labelPadding, 0,
                                                                                    self.bounds.size.width-labelPadding*2,
                                                                                    150));
            return CGSizeMake(size.width, 150 + labelPadding * 2);
  
        }
        else
        {
            _textView.frame = CGRectIntegral(CGRectMake(labelPadding, 0,
                                                        self.bounds.size.width-labelPadding*2,
                                                        textSize.height +  labelPadding * 2));
            return CGSizeMake(size.width, textSize.height + labelPadding * 2);//
        }

    }
}

- (void)setupCaption
{
    if (self.showTextView == NO)
    {
        _label = [[UILabel alloc] initWithFrame:CGRectIntegral(CGRectMake(labelPadding, 0,
                                                                          self.bounds.size.width-labelPadding*2,
                                                                          self.bounds.size.height))];
        _label.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
        _label.opaque = NO;
        _label.backgroundColor = [UIColor clearColor];
        _label.textAlignment = NSTextAlignmentCenter;
        _label.lineBreakMode = NSLineBreakByWordWrapping;
        
        _label.numberOfLines = 0;
        _label.textColor = [UIColor whiteColor];
        _label.font = [UIFont systemFontOfSize:17];
        if ([_photo respondsToSelector:@selector(caption)])
        {
            _label.text = [_photo caption] ? [_photo caption] : @" ";
        }
        [self addSubview:_label];
    }
    else
    {
        _textView = [[UITextView alloc] initWithFrame:CGRectIntegral(CGRectMake(labelPadding, 0,
                                                                          self.bounds.size.width-labelPadding*2,
                                                                          150))];
        //_textView.textContainerInset = UIEdgeInsetsMake(8, 0, 8, 0);
        //_textView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
        _textView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        _textView.opaque = NO;
        _textView.backgroundColor = [UIColor clearColor];
        _textView.textAlignment = NSTextAlignmentCenter;
        _textView.textColor = [UIColor whiteColor];
        _textView.font = [UIFont systemFontOfSize:17];
        _textView.delegate = self;
        if ([_photo respondsToSelector:@selector(caption)])
        {
            _textView.text = [_photo caption] ? [_photo caption] : @" ";
        }
        [self addSubview:_textView];
    }
}

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    return NO;
}


@end
