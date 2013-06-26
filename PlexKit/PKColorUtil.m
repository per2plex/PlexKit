// PKColorUtil.m
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

#import "PKColorUtil.h"
#import "PKMathUtil.h"

UIColor* PKRandomColor()
{
    return PKColorWithHexRgb((int)(PXRandom() * 0xFFFFFF));
}

UIColor* PKColorWithHexRgb(int hexValue)
{
    float red = ((hexValue >> 16) & 0xFF) / 255.0;
    float green = ((hexValue >> 8) & 0xFF) / 255.0;
    float blue = (hexValue & 0xFF) / 255.0;

    return [UIColor colorWithRed:red
        green:green
        blue:blue
        alpha:1.0f];
}

UIColor* PKColorWithHexRgba(int hexValue)
{
    float alpha = ((hexValue >> 24) & 0xFF) / 255.0;
    float red = ((hexValue >> 16) & 0xFF) / 255.0;
    float green = (hexValue >> 8) / 255.0;
    float blue = (hexValue & 0xFF) / 255.0;

    return [UIColor colorWithRed:red
        green:green
        blue:blue
        alpha:alpha];
}
