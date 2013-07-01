// PKSectionLocationDemoBackground.m
//
// Copyright (c) 2013 Till Hagger (http://owesome.ch/)
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

#import "PKSectionLocationDemoBackground.h"


@implementation PKSectionLocationDemoBackground
{
    UIImageView* m_imageView;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        m_imageView = [[UIImageView alloc] init];
        m_imageView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        m_imageView.frame = self.bounds;

        [self addSubview:m_imageView];
    }
    return self;
}

- (void)setRowLocationInSection:(PKTableViewSectionLocation)sectionLocation
{
    switch (sectionLocation)
    {
        case COTableViewSectionLocationTop:
            m_imageView.image =
                [[UIImage imageNamed:@"cell_background-top.png"] stretchableImageWithLeftCapWidth:30
                                                                                     topCapHeight:30];
            break;

        case COTableViewSectionLocationMiddle:
            m_imageView.image =
                    [[UIImage imageNamed:@"cell_background-middle.png"] stretchableImageWithLeftCapWidth:30
                                                                                            topCapHeight:30];
            break;

        case COTableViewSectionLocationBottom:
            m_imageView.image =
                    [[UIImage imageNamed:@"cell_background-bottom.png"] stretchableImageWithLeftCapWidth:30
                                                                                            topCapHeight:30];
            break;

        case COTableViewSectionLocationSingle:
            m_imageView.image =
                    [[UIImage imageNamed:@"cell_background-single.png"] stretchableImageWithLeftCapWidth:30
                                                                                            topCapHeight:30];
            break;
    }
}

@end